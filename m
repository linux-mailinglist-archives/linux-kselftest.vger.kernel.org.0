Return-Path: <linux-kselftest+bounces-1321-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C6D8078E7
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 20:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85AF31C20AA1
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 19:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5290247F75;
	Wed,  6 Dec 2023 19:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YPzN7GRN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9EEBD5A
	for <linux-kselftest@vger.kernel.org>; Wed,  6 Dec 2023 11:51:47 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40c039e9719so1894995e9.1
        for <linux-kselftest@vger.kernel.org>; Wed, 06 Dec 2023 11:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701892306; x=1702497106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=jm7MoA/env00fiO7p1h/h0KrSPPlqjftAjh8tFLIQHg=;
        b=YPzN7GRNmi5hMp5fJUulPa/pU8s9dUa6Oz5u3luT6kwzkyKV3U0MoA/zwTxsZpFUDJ
         3GyfTMKGf2+jX6PjUSu3B/rVR1Vb34KNdo7hBkK+QRtDwdCeBNEu/O1z36udGhafx0fj
         yYSF+EzuNHybC01uIeQaiwmSQ55Sg1y5FVC8i34Ub30ay2h74FulSADX1LnC46nn0wmN
         CegaTcLhIffpxqGMXvpWdz6W1cFSMNOIl8zMEAuzK8dnzSpmWo//sBivgu7n3Im6JeOa
         S2H3v1r+WGYqbXH1n4C/jmR2OSKPpDcoIEIrS18jhKbKNX0YzeK52MxGfh5lqYy5se4B
         aeiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701892306; x=1702497106;
        h=content-transfer-encoding:mime-version:date:message-id:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jm7MoA/env00fiO7p1h/h0KrSPPlqjftAjh8tFLIQHg=;
        b=RJd2JFx8ZL/hEOFfYC/V79NmwBd/Tlsa5M1k3HUQfeUSNt/Z0WshbtpgN/cQMbBWkg
         TzUTJODM2LAaG+EcITqSDhkr5urnmvvz3zRz6q5kLPm1wakLlSFbkbZdbFHNNUkVezXx
         4SqVylYAmsAhrCpYjUOYk4c9HDKQ9HHT2Qh8CT9t5HyNwQFoMZUZfrdePlSJEGkmyowN
         vujmA8MrxhEUyAwpUfxWeJvFT3YhWF2rWN/EpQLVWpcLB4U5W85xQQoEFhiwF1QHGg3I
         u24uiZnVoVX1gm7IydXkF0t1JPkK3OsemDOEUYOA4+kUPMIv1IbnYSOeg4+iv+8GgmdC
         zGvw==
X-Gm-Message-State: AOJu0YxuLwaLxktRhYLJy+SnnQRHsRRp/BVzjRhT4DSFEIrZUsfjAkSN
	2ogHZ9EmKG3/OUo2FA8COMD+5vuFNK7Osg==
X-Google-Smtp-Source: AGHT+IEfYMddWF9gqxFgIMpgrZQlJvd4p3xhQjtYlERgTFA+NHAOkzx0Ut/ItwWue9iGhslXQh2S8A==
X-Received: by 2002:a05:600c:5409:b0:40b:5e59:e9ea with SMTP id he9-20020a05600c540900b0040b5e59e9eamr951540wmb.137.1701892305818;
        Wed, 06 Dec 2023 11:51:45 -0800 (PST)
Received: from DESKTOP-3011VCQ ([160.179.1.54])
        by smtp.gmail.com with ESMTPSA id t4-20020a5d6a44000000b003333298eb4bsm447956wrw.61.2023.12.06.11.51.45
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Dec 2023 11:51:45 -0800 (PST)
From: "mohams" <rakaminalwado@gmail.com>
To: "linux-kselftest" <linux-kselftest@vger.kernel.org> 
Subject: hi
Message-ID: <1b197d58585a4745a56f057e3fced0da@192.168.1.109>
Date: Wed, 06 Dec 2023 16:00:40 -0400
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


