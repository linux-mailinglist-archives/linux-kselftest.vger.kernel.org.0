Return-Path: <linux-kselftest+bounces-1308-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B58FD80776E
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 19:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E74551C209FC
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 18:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326826E5AB;
	Wed,  6 Dec 2023 18:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iGlxXUbs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9559122
	for <linux-kselftest@vger.kernel.org>; Wed,  6 Dec 2023 10:20:18 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40c05ce04a8so1128985e9.0
        for <linux-kselftest@vger.kernel.org>; Wed, 06 Dec 2023 10:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701886817; x=1702491617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=jm7MoA/env00fiO7p1h/h0KrSPPlqjftAjh8tFLIQHg=;
        b=iGlxXUbsBJK5McZcwfsWALThmo/szR6c5tLygfzQaJSxpn0I3BaxZsUpkCOFVcuBQJ
         yI6uh5z7p9JequD8mCaf3jMznPdzP8HJzN+HdFCS1yVQXOdLoWi8QkoRVNyughGIxMLo
         6DxxsNUgDfJ2V9zSIDaFAaHKUumLhnQ+p8Wg6IZ3Fw/JSXHbQIh6x28yqx3vBWMMc8LX
         CarhjBo31FbcEP8HXV8AhMeG7ZKH45LqoDObSrWPTLsSvSzdz7nlmB1taLvqnd2K6mAq
         ZlrvpDuasM3IEcKz0mndVae/F3dY/C0ZPKpIce2cMGdVV9BipDahM1XgXGCAf7G83f64
         2wZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701886817; x=1702491617;
        h=content-transfer-encoding:mime-version:date:message-id:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jm7MoA/env00fiO7p1h/h0KrSPPlqjftAjh8tFLIQHg=;
        b=Twpxxu2dCCB2cBZVuhLsyQcaEwlYBHnf5vMRPH117FZLbdcju00hVe8rVxpwQgHzo2
         tphGUhoW7M+Iyr3SA0MeRqSyjv8qwxBotjpVYi/ZJABZ5dUcBdbiJxJEeVZCgYUWMfuU
         yktq4PzIcLc6IIMd0VCPymDHJxN9G+mwvbyd2y2zg5cxijlmSSeYOH/A+701oEMVZN75
         L6jcYFAvHPqL1+p9zbqOoa4K/Ug2eWZf614rDbUWYTrUOy1dnfKcXPVnaMVT9qjAklum
         xHT6SXsizeefW2plMQjRl/Ns5iZX8q6IUgahqRyWVLd2T+QtG/gdaP2BlmWDLfSJ5qVk
         ZCBg==
X-Gm-Message-State: AOJu0Yzxgf/TmkaNbn9A2tZ4e2QHxwBP8vEarzae55Hwhh81PRHOb+1R
	mfEbWvQQzE6vodK0ru6Zb+pY6Sc/Jnn0Bw==
X-Google-Smtp-Source: AGHT+IEW1j6eOC9/Mk47ndG0hnV5lPKimZ4PqAhdIvziSSLIzdsRTEHvRAzlqc2Ud8uENU+uKsaYpw==
X-Received: by 2002:a1c:4c15:0:b0:40b:5f03:b412 with SMTP id z21-20020a1c4c15000000b0040b5f03b412mr486756wmf.308.1701886817215;
        Wed, 06 Dec 2023 10:20:17 -0800 (PST)
Received: from DESKTOP-3011VCQ ([160.179.1.54])
        by smtp.gmail.com with ESMTPSA id g18-20020a5d46d2000000b0033339da02f9sm284383wrs.110.2023.12.06.10.20.16
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Dec 2023 10:20:16 -0800 (PST)
From: "mohams" <mirnjohan@gmail.com>
To: "linux-kselftest" <linux-kselftest@vger.kernel.org> 
Subject: hi
Message-ID: <57dfb28c5cd3ed4993669cd02ceb24e0@192.168.1.109>
Date: Wed, 06 Dec 2023 14:29:09 -0400
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ascii"
Content-Transfer-Encoding: quoted-printable

hi my friend


