Return-Path: <linux-kselftest+bounces-14240-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B57C193C65F
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 17:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D199A1C2100C
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 15:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A720A19D8A7;
	Thu, 25 Jul 2024 15:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lR/m4czg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E5B18786E;
	Thu, 25 Jul 2024 15:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721921345; cv=none; b=Q2IaGDjHL1XqAAJPmjFxZ4DrrRh/npyQQfYUXNkHX5Azery5XXZFRJUBmGgAlOmjhSITgBsALJr5fveq362560PajYxW1/hx1TSA0HrWwpx8v98quqGO8eauUfVU/CIitW4fcIlUjzNOfyJq4GmFjLZ/zXV0orrqsKZHzFmU138=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721921345; c=relaxed/simple;
	bh=j7iwCZlrH1K6hWVcAl0gOibuq8HOPwjMGUDQAnfnwB0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=eU0G7rGTLghQDRt/bfx4oFJsciM89uum1JAcDsxd12T26JaZhyifvET67QMPd/NiCI//WL9o+sD/GajMQvexI3hf1MCiiRtgpPQcN1SOAQjOZ9pxQuSFTCW89Un5SMxNEy7lHJTuo1CWDhdZvQe6p48prGEq+2csezbLkgouThE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lR/m4czg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E4E6C32782;
	Thu, 25 Jul 2024 15:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721921345;
	bh=j7iwCZlrH1K6hWVcAl0gOibuq8HOPwjMGUDQAnfnwB0=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=lR/m4czgzV9FQAOdUD1gHdPchL+pC8gqnKdtyCEAiOM0chh30Bsj1djpJDjk7aCip
	 XNvi3GOaZnLbb+g9aayLEWdaPbUSEOplIGv4Nkm431OsWt96/8dSZTIS+vMXOUBUam
	 wimr0bI5kzx3i2ikbq7gtjy+4FVHX6S3bUl5ONqUE9nTJOdn8FOvQV/hJN+7k0NDu4
	 wlGDIkRNOPrvMv7+lVxQs2r1wablYCbOfRc6FJf6juOGoV87+FX9VB+f8zbJh7dBtJ
	 8dOjp8cijeoW7A59UBRXsLzIGzLG7MLdDWJUkJlvsvsb88j/zqg9pjj57PWRzE+z/g
	 rNQb5a/0NtRyQ==
Date: Thu, 25 Jul 2024 17:29:02 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Benjamin Tissoires <bentiss@kernel.org>
cc: Shuah Khan <shuah@kernel.org>, linux-input@vger.kernel.org, 
    linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
    bpf@vger.kernel.org
Subject: Re: [PATCH HID 0/4] HID: selftest fixes after merge into 6.11-rc0
 tree
In-Reply-To: <20240723-fix-6-11-bpf-v1-0-b9d770346784@kernel.org>
Message-ID: <nycvar.YFH.7.76.2407251728080.11380@cbobk.fhfr.pm>
References: <20240723-fix-6-11-bpf-v1-0-b9d770346784@kernel.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 23 Jul 2024, Benjamin Tissoires wrote:

> After HID-BPF struct_ops was merged into 6.11-rc0, there are a few
> mishaps:
> - the bpf_wq API changed and needs to be updated here
> - libbpf now auto-attach all the struct_ops it sees in the bpf object,
>   leading to attempting at attaching them multiple times
> 
> Fix the selftests but also prevent the same struct_ops to be attached
> more than once as this enters various locks, confusions, and kernel
> oopses.
> 
> Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> ---
> Benjamin Tissoires (4):
>       selftests/hid: fix bpf_wq new API
>       selftests/hid: disable struct_ops auto-attach
>       HID: bpf: prevent the same struct_ops to be attached more than once
>       selftests/hid: add test for attaching multiple time the same struct_ops

Benjamin,

for the series

	Acked-by: Jiri Kosina <jkosina@suse.com>

Let's get this fixed ASAP. Thanks,

-- 
Jiri Kosina
SUSE Labs


