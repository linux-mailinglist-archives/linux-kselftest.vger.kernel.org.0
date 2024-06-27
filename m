Return-Path: <linux-kselftest+bounces-12853-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8E091A89E
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 16:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D72D1C20C78
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 14:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8042195803;
	Thu, 27 Jun 2024 14:05:27 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D2E1957F2;
	Thu, 27 Jun 2024 14:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719497127; cv=none; b=Zz+pahaQyrrI/mGKrr1vHPpJbNDFMa8H69jA2mYtRaF/kt7BWyCW/cRa/5o1XSj7k4M3eP0vNHpscIKzyCOtKxly7dOqK0fCUYHu+3i0KFyRi4Jk4wsKJjhUHdMXgwNFk/bsueb3WPp7R/rQr6MmWTFQMr+toTKoUobl3TR9Fjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719497127; c=relaxed/simple;
	bh=c4YrhLQIg5j6P0I/KWsBoTgwo2ayPP+t6uwxuckb10Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YH9LPHgQOo/gV2V/TFf+xDLzg7DXq3BG/0D9QYEXBldDbeTI3SBWs1Own2bM8fiyr89mEywq5p4QFkkg+IZDiEGgjsjXyI0xsnkEVWsBY/PPcnMvF/eEPHNSatbDY8RyN8jOseCTwH8Z8oR2F+IO/S5owIB0TRORGdAqZ1uydNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9B4AC2BBFC;
	Thu, 27 Jun 2024 14:05:25 +0000 (UTC)
Date: Thu, 27 Jun 2024 10:05:24 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Yunseong Kim <yskelg@gmail.com>
Cc: Akanksha J N <akanksha@linux.ibm.com>, "Naveen N. Rao"
 <naveen.n.rao@linux.vnet.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Martin Schwidefsky
 <schwidefsky@de.ibm.com>, MichelleJin <shjy180909@gmail.com>,
 linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: selftests/ftrace kprobe_eventname test fails on s390x QEMU
 (KVM/Linux)
Message-ID: <20240627100524.09011f81@rorschach.local.home>
In-Reply-To: <1add7a0a-f91d-4249-9632-424505597e45@gmail.com>
References: <1add7a0a-f91d-4249-9632-424505597e45@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Jun 2024 14:03:14 +0900
Yunseong Kim <yskelg@gmail.com> wrote:

> My environment is QEMU Ubuntu 24.04 KVM Machine Linux version
> 6.8.0-36-generic (buildd@bos01-s390x-012) (s390x-linux-gnu-gcc-13
> (Ubuntu 13.2.0-23ubuntu4) 13.2.0, GNU ld (GNU Binutils for Ubuntu) 2.42) #36

Could you see if you have the same issue on the most recent kernel?

-- Steve

