Return-Path: <linux-kselftest+bounces-39673-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98273B31777
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 14:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93C7A3BF20C
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 12:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976E72FB631;
	Fri, 22 Aug 2025 12:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=0x65c.net header.i=@0x65c.net header.b="IBbjCdOL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m204-227.eu.mailgun.net (m204-227.eu.mailgun.net [161.38.204.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DB92FAC1B
	for <linux-kselftest@vger.kernel.org>; Fri, 22 Aug 2025 12:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.38.204.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755864907; cv=none; b=P+uQ68/2mU7kjqQ6OkwCryBTzSQTrY+vwfOYXn3xn+HGFhMzgyBEKHHQJcjbKcIcozKg+tapwVLXE4lzPdY4pf6ow5qQCUIEhjlsVBDQud8R71YMkOaT/Z4MQqUiqZTOyaCLR/1GUMNDtkFl+ZH3DApQfYOROrc35XWYqhe3SnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755864907; c=relaxed/simple;
	bh=Az/o7brauE8+AmxtPVAg4NVNTdtR5ZdMTbgDqtxdGpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PuBgQL2LjpQ1fSW+Q2tYy7GPO4i4QVIvi1gdXWYq8wuIWv/vQZV2xM3Oyemzn3WqnwlJ8vDGMurxAPe/su0Es+aG/JSXWMHoqpQAyZReX+gTPpy7KAyELxUVTjn6fFeRa+rfJ6NOg8wuhZoCDoTXh439qH8zBYD3XHTnbjolCVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x65c.net; spf=pass smtp.mailfrom=0x65c.net; dkim=pass (2048-bit key) header.d=0x65c.net header.i=@0x65c.net header.b=IBbjCdOL; arc=none smtp.client-ip=161.38.204.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x65c.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x65c.net
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=0x65c.net; q=dns/txt; s=email; t=1755864903; x=1755872103;
 h=Content-Transfer-Encoding: Content-Type: MIME-Version: References: In-Reply-To: Message-ID: Date: Subject: Subject: Cc: To: To: From: From: Sender: Sender;
 bh=E5JPEIWwbUEgx07FyERN8LOom8cbYV9eOajp/a8bmlc=;
 b=IBbjCdOL7xBuSoOufM2ylnnRWZH5WAytESFyh8Um9v9dhgy9JmqYqp5gMWdwSZUIOEWhM3U4TbrNi3Qkua2x0pjafO1IdIe4Xdfq7pxBP/xVmBpRP2x1LiN/ZhBLIc/8VtJSC81fEtLCHaIXyLvCLZ/uZnSaRtxzSFl5cX/MnK6UlXmhigafJSY0sy4h5U8Z5N2RjljkK0D7s4+CAM3AR88Xi7DjHkcPZbuInByVAdqAX5YAc4gCXq4rgRcZ09AP8Vx/HU9wnUzc2ypT/mHKy9UOLd/e8IEoEOKExWdaYMHve/2FPbZ6IpXbrVm6IxqhfLc2IpaCe9n6mCe2aoVvYQ==
X-Mailgun-Sid: WyJlMmQxMSIsImxpbnV4LWtzZWxmdGVzdEB2Z2VyLmtlcm5lbC5vcmciLCI1NGVmNCJd
Received: from fedora (pub082136115007.dh-hfc.datazug.ch [82.136.115.7]) by
 768ff15aeb8381866dc49adec9f57767686591a2ec2869842b26002dbfcaba46 with SMTP id
 68a85f47ec4fa32e70092320; Fri, 22 Aug 2025 12:15:03 GMT
X-Mailgun-Sending-Ip: 161.38.204.227
Sender: alessandro@0x65c.net
From: Alessandro Ratti <alessandro@0x65c.net>
To: liuhangbin@gmail.com
Cc: alessandro@0x65c.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	skhan@linuxfoundation.org
Subject: [PATCH net-next v2] selftests: rtnetlink: skip tests if tools or feats are missing
Date: Fri, 22 Aug 2025 14:08:41 +0200
Message-ID: <20250822121456.874759-1-alessandro@0x65c.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <aKfDOSx3C8NbMJsw@fedora>
References: <aKfDOSx3C8NbMJsw@fedora>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On Fri, 22 Aug 2025 at 03:09, Hangbin Liu <liuhangbin@gmail.com> wrote:

>
> Hi Alessandro,
>
> Next time, please add the version tag and target branch in the subject.
> e.g. [PATCHv2 net-next] your subject
>
> I'm not sure if the lack of a version number will have an impact on the
> patch work.
>
> The change looks good to me.
>
> Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
>
Hi Hangbin,

Thank you again for the review and for pointing out the correct subject
format.

Apologies for the oversight — I’ve updated the patch accordingly and am
re-sending it with the correct subject line and the Reviewed-by tag.

Lesson learned for next time :)

Best regards,  
Alessandro

