Return-Path: <linux-kselftest+bounces-1318-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9B4807882
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 20:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B47E281744
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 19:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403A56E2D8;
	Wed,  6 Dec 2023 19:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R9FfffOB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E583B2
	for <linux-kselftest@vger.kernel.org>; Wed,  6 Dec 2023 11:21:56 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id 5b1f17b1804b1-40b5155e154so1729255e9.3
        for <linux-kselftest@vger.kernel.org>; Wed, 06 Dec 2023 11:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701890514; x=1702495314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=jm7MoA/env00fiO7p1h/h0KrSPPlqjftAjh8tFLIQHg=;
        b=R9FfffOBt3d83CsFQkem4isZAWha+7EXPrx+W9nWXl6gNBjwI+QpCRGmPd7fvVYNuM
         sA1SEqIudJNn72Fq0IGyjNUIL6xgRMa0a2IPTNxsRcCAJyLU21CpJA8P+T4QxLMaIl3H
         4Demu7lVGadhJ+w7CSMwSAnCIOEjggj2J45zACTy3YMiXA/eSUjonvpXNqfXEqkAZxbn
         kTiOuTDF3pWYisR4q4qvQ/lh0Kj37UBWKyuOh8r7z0tvqmbQsvWVr/Ho1QMVAN91SSkJ
         QlQ/k2SQqmtL/qOPyKEfC19zGbg2LNu2HCCwYaXgKQBe4h0/CZ2QpGIx4CHF44MBKYZQ
         CDrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701890514; x=1702495314;
        h=content-transfer-encoding:mime-version:date:message-id:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jm7MoA/env00fiO7p1h/h0KrSPPlqjftAjh8tFLIQHg=;
        b=ZwqZS7KdIxHkRfVfgeCUmqtgdZgmbaVtw00mUcE5E4KyjH7rHekN2jPp+bYO3WUTm4
         jbjYknWTUbod7caLWTPpiTBVvtzR+BAVwqgOJlrd4rkAqUzaGQXu7fDLlkIzPzNrGO5S
         vkb8M8D9G9Q3E/J+qiabzoWGThYPLMO36SpJT+RI3+LOT1JzjbVvsPKmytFzZwmHFQTJ
         KaktOUP2e/6VekzWWaLgqp/dEA7O4cFAzCtjcFkmv4TGOlujilsPyi6Jv412wLeMXAOc
         N6ktsr+q8drIoEtIa6YqLsGOFsOjt7dmTOf4AmfbM8eaYtNfrtSmcGLxkioNkdevUGgA
         N1aA==
X-Gm-Message-State: AOJu0YxFTsfAbpXeiKbWif4IqqbP5FfmPqwK+U5tilyoNz7FXBlFTqN/
	sogmxIZjMXKm3wbWETDaw9QCIntSUudQeg==
X-Google-Smtp-Source: AGHT+IEVvt6nTcpL1UXLZtKiIYRdtPAW5/VhKQQLA2FVemAKxvYg8HSABKucyqiutVMIu9NZzOKO5g==
X-Received: by 2002:a05:600c:3502:b0:40b:5e4a:4063 with SMTP id h2-20020a05600c350200b0040b5e4a4063mr859711wmq.131.1701890514487;
        Wed, 06 Dec 2023 11:21:54 -0800 (PST)
Received: from DESKTOP-3011VCQ ([160.179.1.54])
        by smtp.gmail.com with ESMTPSA id k21-20020a05600c1c9500b004053e9276easm576878wms.32.2023.12.06.11.21.52
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Dec 2023 11:21:54 -0800 (PST)
From: "mohams" <alisbahkora@gmail.com>
To: "linux-kselftest" <linux-kselftest@vger.kernel.org> 
Subject: hi
Message-ID: <4cfcab9bfcfd1b4ca0a9f150ee8140e6@192.168.1.109>
Date: Wed, 06 Dec 2023 15:30:26 -0400
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


