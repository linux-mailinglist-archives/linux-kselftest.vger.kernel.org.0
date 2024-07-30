Return-Path: <linux-kselftest+bounces-14464-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2FF940FA6
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 12:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82C301F24359
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 10:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9939D1A0719;
	Tue, 30 Jul 2024 10:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="bggJ3AuP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7E912EBCE;
	Tue, 30 Jul 2024 10:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722335722; cv=none; b=TM/46MI9biAumchCaoMQ53C6lJGRaQx8d/JLypaLVwbNSs/InKSUNUeULEpbiawEM5MhP0yE0792ZAKkc3jx82K2xoCPqhP4CduwuuJIseRUyuB9LzPIS0zfWYqE9YUG7Ga5dUXkrEuAZXa2qpHTx7PDssJrX+4eEvORPRqWxnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722335722; c=relaxed/simple;
	bh=rxxG15P5dtUF0Ys7cOHlwSHSam9D2lCrV5gOJFfMim8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s3dpCNVZ9ufFITr/tdjzVAVv/fg5r72H7V40GC3k4XuVb3zUyuHOdrck8t0o8S6Cxu0n9nnEkCjXLng1Gsws6H21XQNx9sMxd79PeQpn1XnpNQ7ZO5XwzTCstfLtHB2VObBRWSrGFTOnM/c3hFVTPPxJzg4X96JeysaVKNcjUpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=bggJ3AuP; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1722335719;
	bh=rxxG15P5dtUF0Ys7cOHlwSHSam9D2lCrV5gOJFfMim8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bggJ3AuP9Z+21DuCxjktjNK8n80+Ug3I6LACgVCIAo3vmBR75Jt4+9aFuJzWXQ00J
	 W4s9ACe3TwiizC7zlfj+HwlXS7xknsKIPZzY9bllHFCKdl09Z3NgEdGK3asgSuLgyW
	 sPB0xAozmraZRzUmCtbdkLVghlneMiEsPfhjqQgbsKzSBzVHkA03O54yrKj+02s4XO
	 u850WLyow/P7+uc53jyNEryO+n6Fe7R3qtf5y8KjCTaP6gaH9D9+7jT5g/9v7fcVVx
	 WutHAI8jlI/ntJB7079sqBUqfLrrTxC8liIWfYRD8T0MfUoJ0RfxdmWq4uAUNvz2rn
	 fjf5dxh51kv8g==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 91A4E3780B50;
	Tue, 30 Jul 2024 10:35:18 +0000 (UTC)
From: Laura Nao <laura.nao@collabora.com>
To: skhan@linuxfoundation.org
Cc: gregkh@linuxfoundation.org,
	kernel@collabora.com,
	laura.nao@collabora.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	nfraprado@collabora.com,
	shuah@kernel.org
Subject: Re: [PATCH] selftests: ksft: Track skipped tests when finishing the test suite
Date: Tue, 30 Jul 2024 12:35:43 +0200
Message-Id: <20240730103543.33884-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <2bb2d338-cd00-4ac2-b8bd-5579eae82637@linuxfoundation.org>
References: <2bb2d338-cd00-4ac2-b8bd-5579eae82637@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 7/29/24 22:06, Shuah Khan wrote:
> On 7/29/24 08:52, Laura Nao wrote:
>> Hi Shuah,
>>
>> On 7/23/24 18:17, Shuah Khan wrote:
>>> On 7/22/24 09:43, Laura Nao wrote:
>>>> Consider skipped tests in addition to passed tests when evaluating the
>>>> overall result of the test suite in the finished() helper.
>>>>
> 
> I am finally with you now. Can you please more information in your
> short log and commit log.
> 
> Isn't this a bug fix? Current logic before this change will report
> tests failed if there are any skipped tests?
> 
> Can you send v2 calling it a fix and explain the problem clearly.
>

v2 sent: https://lore.kernel.org/all/20240730102928.33182-1-laura.nao@collabora.com/
 
> This isn't problem in this patch, but I am concerned about how
> simply calling tests passed without calling out skipped tests.
> 
> This problem could be solved by printing a message at the end of tests
> for non-zero skipped test conditions to say the coverage could be
> increased by enabling config options.
>

Right. We can send a separate patch to address this.

Thanks!

Laura

