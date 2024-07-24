Return-Path: <linux-kselftest+bounces-14162-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE18193B50E
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 18:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98CAF282AB6
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 16:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB68156967;
	Wed, 24 Jul 2024 16:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="URi012NP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67A610F4;
	Wed, 24 Jul 2024 16:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721838709; cv=none; b=mxohZjVbkLXaRiFhB3Eo65n/mP/qf7dm/X13ilPkSVHVWzXd4yHmyJU2ecHE1g89PDHPflEri+Im7IwxmlOaZaYsV1n0sNlPxp0NHEsBX0vhWAbpQ8UP6nNZn1vOVfaKnWnEztAmtPU4gJ8X+u7umZ4Rc/FDR6fLf9kNzzl8Sbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721838709; c=relaxed/simple;
	bh=gQpr6s0FmDNYdzI3ol/C82NZcG9bLRW5SExa+M+sMK8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=m6wTIPlX56RlKtvVg/tMiTu7xDILtlyrBF8Jby06Q3XGyCUFo6JbCnxMUocktafHmOW37Hb/A6rFKm6Zwynz4Iv0iwr0Lxjr0jmQjy9MON8g1A9W/XrcCx/YY/0VzBLbOsk86XOcQg+HqRVB81zv/lEquuEZf8ewYxcYL0XsIuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=URi012NP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCBA5C32781;
	Wed, 24 Jul 2024 16:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721838709;
	bh=gQpr6s0FmDNYdzI3ol/C82NZcG9bLRW5SExa+M+sMK8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=URi012NPLWMMvEqckNtT7V8UfnFrQlqaTZ3ZcN57bxyCcGXpIns6+HQWXPZI1T9UY
	 Ewqot4iDndG0gJ1dqTte9T5iqvJ3bj/R/jcQxsXjugd4JxnOhXUglNPi1CpukWYGoM
	 wNZiiz0qDZkYmzuuYNpyaqH4blOfdVYUJruyxLoGJiHynfMfiifT5pMSmsx4GJFHGk
	 Gy3tOx4binyeuLCBZRr9wf1ZWhzoGz40Gvi6DhPZs0/T4JyXHjczwIncziY1wOXRBD
	 4fDaOoIhm5x7X89Wid+5S9+jUDQAxHaOt9iMrmAAI15qeh6RuTbBeIlj/2vwa3abXe
	 1pX2fkjMkFAdw==
From: Benjamin Tissoires <bentiss@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20240723-fix-6-11-bpf-v1-0-b9d770346784@kernel.org>
References: <20240723-fix-6-11-bpf-v1-0-b9d770346784@kernel.org>
Subject: Re: [PATCH HID 0/4] HID: selftest fixes after merge into 6.11-rc0
 tree
Message-Id: <172183870763.647684.3851059862651926785.b4-ty@kernel.org>
Date: Wed, 24 Jul 2024 18:31:47 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0

On Tue, 23 Jul 2024 18:21:50 +0200, Benjamin Tissoires wrote:
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
> [...]

Applied to hid/hid.git (for-6.11/upstream-fixes), thanks!

[1/4] selftests/hid: fix bpf_wq new API
      https://git.kernel.org/hid/hid/c/ff9fbcafbaf1
[2/4] selftests/hid: disable struct_ops auto-attach
      https://git.kernel.org/hid/hid/c/f64c1a459339
[3/4] HID: bpf: prevent the same struct_ops to be attached more than once
      https://git.kernel.org/hid/hid/c/acd34cfc48b3
[4/4] selftests/hid: add test for attaching multiple time the same struct_ops
      https://git.kernel.org/hid/hid/c/facdbdfe0e62

Cheers,
-- 
Benjamin Tissoires <bentiss@kernel.org>


