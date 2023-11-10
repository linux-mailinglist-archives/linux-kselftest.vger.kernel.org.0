Return-Path: <linux-kselftest+bounces-7-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE8F7E8201
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Nov 2023 19:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1A621C209CD
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Nov 2023 18:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32B13AC19;
	Fri, 10 Nov 2023 18:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Mq8O9/RS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AC239878;
	Fri, 10 Nov 2023 18:51:47 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF051199F;
	Fri, 10 Nov 2023 10:51:46 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70210C433C9;
	Fri, 10 Nov 2023 18:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1699642305;
	bh=5EsdFpo+n5trUWFX0VrZzBijTcaJAiV+yar8oOtb48I=;
	h=Date:From:To:Subject:From;
	b=Mq8O9/RS2b9oSO2hvUh7dQH1MEn7Wc4xSuWopL0Bpg7JIjs4oe3HCDBcDn6hOGfzk
	 laEnQ92cnxQaPYuCgwG6EJLP2chjZodN/036lEwFAtclH+623CZzYNA8PH94yCR5Dn
	 nRg0hH+cDfrSz9O9DgeYKIR7/4XCTMBCH8rAKWaI=
Date: Fri, 10 Nov 2023 13:51:44 -0500
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: linux-embedded@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-fbdev@vger.kernel.org, linux-fpga@vger.kernel.org, linux-fscrypt@vger.kernel.org, 
	linux-gcc@vger.kernel.org, linux-gpio@vger.kernel.org, linux-hams@vger.kernel.org, 
	linux-hexagon@vger.kernel.org, linux-hotplug@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-ia64@vger.kernel.org, linux-ide@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-input@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-m68k@vger.kernel.org, linux-man@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-mmc@vger.kernel.org, linux-msdos@vger.kernel.org
Subject: PSA: This list is being migrated (no action required)
Message-ID: <cfriwrxovqzcrptf74ccq52lcqj2nsergucufsz6wlh45fdnz3@z5e5y2lowbq2>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Level: ***

Hello, all:

This list is being migrated to new vger infrastructure. No action is required
on your part and there will be no change in how you interact with this list
after the migration is completed.

There will be a short 30-minute delay to the list archives on lore.kernel.org.
Once the backend work is done, I will follow up with another message.

-K

