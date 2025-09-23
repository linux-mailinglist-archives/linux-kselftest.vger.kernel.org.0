Return-Path: <linux-kselftest+bounces-42161-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B310B97E67
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 02:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D1EF323DA9
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 00:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D8116F265;
	Wed, 24 Sep 2025 00:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maguitec.com.mx header.i=@maguitec.com.mx header.b="LMYT4k5A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-g3-154.zohomail360.com (sender4-g3-154.zohomail360.com [136.143.188.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EE07260F
	for <linux-kselftest@vger.kernel.org>; Wed, 24 Sep 2025 00:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.154
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758674078; cv=pass; b=YB/mxwaGVYKnPvCbgjZCTVgE9IDxPTemLZqZbo9ueGz6dowo/LV5EBIH5u+ubNLIB63f0jZ3huag5bHXUvBqXckr0LzA1YpuoXuqMTtj3pUvTpye/ojEzyKVF1idTsz7HW/w8Set5GYLRvvjq3utnkZ6oF+aqlmOGK/3cbFogkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758674078; c=relaxed/simple;
	bh=cg8UCECMP9sfCpa9jDWxwhtvfiCf9NWTbFkc6uHuFvc=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type; b=YdQa7UDYWMhwLwGhBERAUJWr+h5Uq7AHr5GMLv2t8OwEPjOcXhg75sTUig+v754qnjQRuj8AOWrRUS+iYUExpGpoxCEQHa/MrNYTuhRjE+uaMmcxJwGkA3+fV+quDuy7SGJDJIB8Cdfq05YqW4sA50Ow5a6UkRouy1e/dBDpRdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maguitec.com.mx; spf=pass smtp.mailfrom=bounce-zem.maguitec.com.mx; dkim=pass (1024-bit key) header.d=maguitec.com.mx header.i=@maguitec.com.mx header.b=LMYT4k5A; arc=pass smtp.client-ip=136.143.188.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maguitec.com.mx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce-zem.maguitec.com.mx
ARC-Seal: i=1; a=rsa-sha256; t=1758674075; cv=none; 
	d=us.zohomail360.com; s=zohoarc; 
	b=bFDLcNBH0z9psDvCoBarVPGSxXqHx0X7HmbCa1u++ytTCuHl29htIixmjv569eMd+sPrvpLXpubJceLjgD1OrnvSYCnVoBzr6NHUD2Jiy6JpYqyDhxAUy5tgtsA4A1IFcXPSjVVt1sNIKYqkVhqMe+f41bX5u0sE+NEj19fQYW8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=us.zohomail360.com; s=zohoarc; 
	t=1758674075; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:MIME-Version:Message-ID:Reply-To:Reply-To:Subject:Subject:To:To:Message-Id:Cc; 
	bh=cg8UCECMP9sfCpa9jDWxwhtvfiCf9NWTbFkc6uHuFvc=; 
	b=W2EnCXoWejiayHr7fxd/nQ9hV+AQ6eELRuV8nAL5V5GWvNwMJehU4uvAR1Mz4bQgbjtsKozX+eAJ5EOZX0Y6VlqU2NC8i7WlhU32YuoC+QwzfweScMR8OdTaP+5iBIgqXdHL4v6v8vRsRPLzJYcv6eZ9tqXmAiz1054HVhSfDcc=
ARC-Authentication-Results: i=1; mx.us.zohomail360.com;
	dkim=pass  header.i=maguitec.com.mx;
	spf=pass  smtp.mailfrom=investorrelations+9a839d40-98d8-11f0-9ce0-52540088df93_vt1@bounce-zem.maguitec.com.mx;
	dmarc=pass header.from=<investorrelations@maguitec.com.mx>
Received: by mx.zohomail.com with SMTPS id 1758671652804951.8831669764404;
	Tue, 23 Sep 2025 16:54:12 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; b=LMYT4k5AwH9skV8N4HkNBnIea+T2L4DjF3qPaiIa5vqeQrsvzvCOl5fw0NY+rgRUNWUNlmoiu3ucNjPxG7IdS95g3MW6rmPu2ItU2/NnfeJSvPqhR9BR2tA2O33Z/gntRr9trSTMTb3JXPFgrsHMRdKKUW0zvb0lzlpDkTAPc94=; c=relaxed/relaxed; s=15205840; d=maguitec.com.mx; v=1; bh=cg8UCECMP9sfCpa9jDWxwhtvfiCf9NWTbFkc6uHuFvc=; h=date:from:reply-to:to:message-id:subject:mime-version:content-type:content-transfer-encoding:date:from:reply-to:to:message-id:subject;
Date: Tue, 23 Sep 2025 16:54:12 -0700 (PDT)
From: Al Sayyid Sultan <investorrelations@maguitec.com.mx>
Reply-To: investorrelations@alhaitham-investment.ae
To: linux-kselftest@vger.kernel.org
Message-ID: <2d6f.1aedd99b146bc1ac.m1.9a839d40-98d8-11f0-9ce0-52540088df93.19978ffc514@bounce-zem.maguitec.com.mx>
Subject: Thematic Funds Letter Of Intent
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
content-transfer-encoding-Orig: quoted-printable
content-type-Orig: text/plain;\r\n\tcharset="utf-8"
Original-Envelope-Id: 2d6f.1aedd99b146bc1ac.m1.9a839d40-98d8-11f0-9ce0-52540088df93.19978ffc514
X-JID: 2d6f.1aedd99b146bc1ac.s1.9a839d40-98d8-11f0-9ce0-52540088df93.19978ffc514
TM-MAIL-JID: 2d6f.1aedd99b146bc1ac.m1.9a839d40-98d8-11f0-9ce0-52540088df93.19978ffc514
X-App-Message-ID: 2d6f.1aedd99b146bc1ac.m1.9a839d40-98d8-11f0-9ce0-52540088df93.19978ffc514
X-Report-Abuse: <abuse+2d6f.1aedd99b146bc1ac.m1.9a839d40-98d8-11f0-9ce0-52540088df93.19978ffc514@zeptomail.com>
X-ZohoMailClient: External

To: linux-kselftest@vger.kernel.org
Date: 24-09-2025
Thematic Funds Letter Of Intent

It's a pleasure to connect with you

Having been referred to your investment by my team, we would be=20
honored to review your available investment projects for onward=20
referral to my principal investors who can allocate capital for=20
the financing of it.

kindly advise at your convenience

Best Regards,

Respectfully,
Al Sayyid Sultan Yarub Al Busaidi
Director

