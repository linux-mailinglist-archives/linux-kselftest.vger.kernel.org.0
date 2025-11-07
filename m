Return-Path: <linux-kselftest+bounces-45048-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D19C3E2C0
	for <lists+linux-kselftest@lfdr.de>; Fri, 07 Nov 2025 02:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BCC794EB598
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Nov 2025 01:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0E12FB0BE;
	Fri,  7 Nov 2025 01:56:21 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cmccmta1.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052C02F3C09;
	Fri,  7 Nov 2025 01:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762480581; cv=none; b=DXE2a2IjZhQzEw8XiiTkEJRoUXq0fpqFLZOaQH5GXvj7ATmV9zr5lAgfi1fYIRIQWhPNUvtCM4Hh0IhtEOLPidvtP/HrnT8wVS8c8hqOqmWBOTa6fgoiU+8d86/fToyP/8jLdHZz0XAo4FHrM7g6E6KOOdSDinRFs7BRPO+s8OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762480581; c=relaxed/simple;
	bh=Njn2wOVC38pXs9fDIj9fCvncVfrHySQHPD0eUGmG+Qw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nAbXX5XW7zsxcHQex8qe1IS0JM7Ctl2evgJVba5SPEOQ8b02javRWdGALVajSw3OYSdIrM7+xgIhvbK/ESPFpRFBXp4lFnUJq5gV2FFkjXegO79tZP9o6gbHNI9N0eog3S8RftNkw6UGQDlE3seHfyQnBMNW7iSVbCOKhhEqBCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee4690d51b5605-456a7;
	Fri, 07 Nov 2025 09:56:07 +0800 (CST)
X-RM-TRANSID:2ee4690d51b5605-456a7
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from FHB-W5100149 (unknown[10.55.1.70])
	by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee7690d51b5b08-690b5;
	Fri, 07 Nov 2025 09:56:07 +0800 (CST)
X-RM-TRANSID:2ee7690d51b5b08-690b5
From: Zhang Chujun <zhangchujun@cmss.chinamobile.com>
To: skhan@linuxfoundation.org
Cc: dmaengine@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	vkoul@kernel.org,
	zhangchujun@cmss.chinamobile.com
Subject: Re: [PATCH] dma_map_benchmark: fix incorrect array access in printf
Date: Fri,  7 Nov 2025 09:55:51 +0800
Message-ID: <20251107015604.2029-1-zhangchujun@cmss.chinamobile.com>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <250fe2c8-eeef-4764-ad50-d5e5987fbd38@linuxfoundation.org>
References: <250fe2c8-eeef-4764-ad50-d5e5987fbd38@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

On Tue, Nov 05, 2025 at 08:30:00PM +0800, Zhang Chujun wrote:
> The printf statement attempts to print the DMA direction string using
> the syntax 'dir[directions]', which is an invalid array access. The
> variable 'dir' is an integer, and 'directions' is a char pointer array.
> This incorrect syntax should be 'directions[dir]', using 'dir' as the
> index into the 'directions' array. Fix this by correcting the array
> access from 'dir[directions]' to 'directions[dir]'.

Hi Shuah,

Thanks for your patience.

I found this issue while carefully reading the code in
`dma_map_benchmark.c`. The expression `dir[directions]` stood out because
`dir` is an integer (enum or int), while `directions` is a string array —
so using `dir` as the index into `directions` is the correct form.
Although C allows `a[b]` and `b[a]` syntactically due to pointer arithmetic,
in this context `dir[directions]` is logically wrong and would print an
unexpected (likely garbage) string, since it treats the address of the
string array as an array indexed by a small integer.

The compiler doesn’t warn because `dir[directions]` is technically valid
C (equivalent to `*(directions + dir)`), but semantically it’s backwards
and breaks the intended output.

Sorry for sending the patch twice, I’ll make sure to follow the proper
mailing list guidelines going forward.

Best regards,
Zhang Chujun



