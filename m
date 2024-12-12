Return-Path: <linux-kselftest+bounces-23241-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49EA09EE01E
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2024 08:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FD66188834A
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2024 07:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF974185B67;
	Thu, 12 Dec 2024 07:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ox0la8m/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43A5259485;
	Thu, 12 Dec 2024 07:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733987897; cv=none; b=aWmhfIqaVOAcboFNappcO1Rf03moLxvYTmHytLLPcIMngWxaO3iDzTAQiJrHAdi0tHu4ZiiiqyIi0Fng3zofrpN4Dzc/aFd/ElrYjWcuU4epi3NGE1TEFv0D6+g6x/E67Wp6m0KyoLJJ+GkWMrb8JY3x6Iccv1Lb1/F8rctOGKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733987897; c=relaxed/simple;
	bh=YC83PvobOTU6cIRoe0xXrvh9Ld0bWXMQPLb/UNtmXFI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=dV5cnWz4PSTh8OA5TCdwkTejzo/i39IGteLr5E2vS4vQM7r95Gv88sRA0mz5P0DT9LG7piaFMRV2xVI8zEpX80u01nuDq80R/pJaei0xVyxV4BpA+FW1OIRW9pnybu9LBEo6SjlBIgIv4Y+aTOxXUIBx6L/DhtFoS4uoQoVG3c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ox0la8m/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0820AC4CECE;
	Thu, 12 Dec 2024 07:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1733987897;
	bh=YC83PvobOTU6cIRoe0xXrvh9Ld0bWXMQPLb/UNtmXFI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ox0la8m/OCbum+U9rQiZzEETcQCknipsmScqa6V6u2JydWtbv/XrHmACIEu1KApEG
	 En+z7WZD+72UI+QRhEtim2GmexTyqNdJFODeDHhZH/XFu2zpfwbXItDIKJOpY+vYRW
	 ZaagrOugRFI3YNGb+1uPfO2DlxjRHwKaVbL19Glk=
Date: Wed, 11 Dec 2024 23:18:16 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
Cc: davidgow@google.com, npitre@baylibre.com, stern@rowland.harvard.edu,
 u.kleine-koenig@baylibre.com, skhan@linuxfoundation.org,
 andriy.shevchenko@linux.intel.com, rbm@suse.com,
 linux-kselftest@vger.kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] lib/math: Add int_sqrt test suite
Message-Id: <20241211231816.9857d14e07251165e247eb51@linux-foundation.org>
In-Reply-To: <20241212021259.20591-1-luis.hernandez093@gmail.com>
References: <20241212021259.20591-1-luis.hernandez093@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Dec 2024 21:12:58 -0500 Luis Felipe Hernandez <luis.hernandez093@gmail.com> wrote:

> Adds test suite for integer based square root function.
> 
> The test suite is designed to verify the correctness of the int_sqrt()
> math library function.
> 

my x86_64 allmodconfig build says

  AR      built-in.a
  AR      vmlinux.a
error: the following would cause module name conflict:
  lib/math/tests/int_pow_kunit.ko
  lib/math/tests/int_pow_kunit.ko
make[1]: *** [/usr/src/25/Makefile:1925: modules_check] Error 1


