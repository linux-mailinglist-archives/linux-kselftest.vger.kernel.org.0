Return-Path: <linux-kselftest+bounces-1323-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B973680791E
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 21:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FF6AB209BF
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 20:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1FC6E2D8;
	Wed,  6 Dec 2023 20:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9T77863"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE37C6
	for <linux-kselftest@vger.kernel.org>; Wed,  6 Dec 2023 12:06:01 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-332c0c32d19so212172f8f.3
        for <linux-kselftest@vger.kernel.org>; Wed, 06 Dec 2023 12:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701893160; x=1702497960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=jm7MoA/env00fiO7p1h/h0KrSPPlqjftAjh8tFLIQHg=;
        b=V9T778639aNz6yHmy+cC+W1/EleycQD+4kpTpSaOcriM7y8pNu1d0RXk4URlbyiRUv
         sV3vvvMY+U0p2EzVl8J4LhW6uX3MX+RPppZ5MDV1RAPBoR14KBst0eepfxv+bc4iNTdz
         RDw48yFn+Wd7gV2/fUt5ydw6V3hac1nP5tXOsoh5mXemTFOX6mzcJbaHo3RaEwuXwPle
         rSOGS2HoEbVe16Df718xpz1b4veC3IKLelb0olZ+ZkRpBNC2363rHb3W0ExNyZz3dM37
         5SifgPwbN6u3KiAFTYdc/Q4aCgNyImdaR14knHNhdwaonHSkpv5L9I1+Fru8x7O7gcYf
         V8iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701893160; x=1702497960;
        h=content-transfer-encoding:mime-version:date:message-id:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jm7MoA/env00fiO7p1h/h0KrSPPlqjftAjh8tFLIQHg=;
        b=mPd199Cr8EalzKHPThLCGirxh6sOdMIxLBr0J3kYP1JCP4Gdn5vKEdb5abr2YeE9XY
         /BXbdF7UVTE8IUKXmfnZS0NH/CXE4UwQ114pKsJ7fYpAerzAxEptpNACL6pFe5QgzYbo
         UgYL8NWnZ8hU38LrgYJ14V0Dn3yFjGWtNDlUuTOlEBSrrgrT1xuDg3gF4ejie20BFmPy
         rmyrOnKbaCUn7TdHKSyn4F+lG7Axhwk32HxFcorW3EXXCBGdsoLWj3Z4ScOZRvyC3cpQ
         rBdkggs2DoepcNmkLP5Wdg/O4fyaAD3kiKdYSYBvG27/bTpHYGlroot9nSE1mCLyERUs
         SKQA==
X-Gm-Message-State: AOJu0YyER+JQ+9dEPPwWUiZUO00mrC068HLX09NP7S3kDbJA4J2HZlm/
	Aa3un5CyUTIDqMrh0Uaa595k6a6l9VpB
X-Google-Smtp-Source: AGHT+IHlMV/0sB5OEMtJeGK627rm/8H71F0TqHJ1RTytJ8CVVRGOVZjaY01MgqyeizAzUtWEEmwXKg==
X-Received: by 2002:a5d:4712:0:b0:333:2fd2:2f0d with SMTP id y18-20020a5d4712000000b003332fd22f0dmr853691wrq.134.1701893160257;
        Wed, 06 Dec 2023 12:06:00 -0800 (PST)
Received: from DESKTOP-3011VCQ ([160.179.1.54])
        by smtp.gmail.com with ESMTPSA id dp8-20020a0560000c8800b003334a0513dbsm458550wrb.67.2023.12.06.12.05.59
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Dec 2023 12:06:00 -0800 (PST)
From: "mohams" <hahmanl777@gmail.com>
To: "linux-kselftest" <linux-kselftest@vger.kernel.org> 
Subject: hi
Message-ID: <e8f36e678acce04ab9788eb15668e0d3@192.168.1.109>
Date: Wed, 06 Dec 2023 16:15:01 -0400
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


