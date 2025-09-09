Return-Path: <linux-kselftest+bounces-41067-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0649B507DD
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 23:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44AB47A8A9C
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 21:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5C9257437;
	Tue,  9 Sep 2025 21:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SQRF7jDb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECECF2517B9;
	Tue,  9 Sep 2025 21:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757452364; cv=none; b=R/n90wL/0A0nwvQosldDNFzL1zE7Ui4ZX3jXRJWoSH/0Aei+RiiksikR6r7+ZxZwbwybKC6eArevxJRlD2SA/zXxjqSVtcuKcwWYOQyhIDp1eqszdfWfwXtUUlkvFKL7Wo4O/atMnl2E+Tzr6H22xMaL6pk2+9oPRrj7kF/SauU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757452364; c=relaxed/simple;
	bh=ezTZdY1rg6AngguOp9RzeNdcL1r5kQPAjVb8c/OH8V8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=G3XkMZwzGKH+DqeObHbkVP6PqAnGZQgw9vK17sDubhedjy+nbuCVidSk7dA349sBURQNgjInGX5W1LZXhwAIbJgzsWr0sbu92Ow9jVPf1ZnNH1TkvJWCpA5yL3HwouDkhX1Gs2F7Sv5MciPLwkJW3oySP9iiypea5QiyC2L/J5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SQRF7jDb; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-55f76277413so6910059e87.3;
        Tue, 09 Sep 2025 14:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757452361; x=1758057161; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Tz/IpzE/DdI0rGgo65nklqWQdBn/OAu+IdxpAGW8DT0=;
        b=SQRF7jDbZ4d363qld64Cgh37amaZvmK3UwUuxacbA9cXgNcBr8+qoy2VqEDY9Vfrep
         qCiTaCZkg60kZaVJFGa88Ofl+L7j/soIq9tm+gY2GzJfxSnLNijf3e+DOQas9YyJyFTJ
         rEYFKJl1vbXpTbWPJyElC8Qh5YNuiLegfiT9FTY0XhxYno9+cnLqsZ3Bx//QOYv1IZFu
         nKNC51GnNN225XWXaZWjXFtZTit/W8T6mInrHfSidkjgRCzlkPG+FD+so3sK7TSKjvip
         x2Ec7MALdpX+TKEdsnoAbBSGQto/Aieysa7AoTKc31gBhck9fawp+GTfOiy5vrEwEzc1
         Rifw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757452361; x=1758057161;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tz/IpzE/DdI0rGgo65nklqWQdBn/OAu+IdxpAGW8DT0=;
        b=FPMeYQEZcljPeorfOqTxUsmhGjTs+PX+B/tPejeE5IjX10uULTFQROx+DqK2D719Io
         6Ji2JjFSjT2koQ9MJ+AFL84WNGBSjmJc8FxJUYFFDlkQZMC3oWxvNf/pjeCRiWhUsAQp
         PiL7YGW7QzJ8aTerS7AwhRj8DjwCXD7m7ttx+gm+P7THByhbiJtH/qr7G7BTrgQBpSz+
         AjL1ti9/iKovXIkK8rvHRGXlpEXsCuO41+lXHOvYEGbwl9iXA9d3qBY6wtWqb73b8NBV
         fiqyUNhtw0eBFQveq8zxx0pS3Sb80uK2rhONtWOBtak2ThjQMJYNK5wQiQ3mt2NZEeQu
         nNMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUakvhDLrfTMUxSaxnd67KNIV5BvdvPJrLcwpqJ6MrIScUqtWFIj8SralnYergugAztNZVdeclMV6GztwSaD0/a@vger.kernel.org, AJvYcCVoKd09Hm1rmCXIIZxD1CKYF7/zhR/v+uAJ1Isa4Bm/GnhHOlgoIM7XGA2uCFL5USqwqwgLGasLigoRa0M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmuPHOE1lHjzWBohT6yshRPlfc0boW2i++AwYgpEixZG1pdywR
	lRC9k7DFv16BLaRKiTQVdr9XSgpTlJqaC3nZb5rylWkM9kNo4UVyRNKB
X-Gm-Gg: ASbGncsSd39cLkr7HemWreCtfIMW6S9OvFEdXyV84jXZttmj0rmmOagYdSGvNL/M+yn
	PoUb9Ic2yJFufuz7/KFm0omPCvkr1Ct5tszIHbZhzr78jHFsRPPP2XKGdL4W+J3a+5GoL8KFp0r
	J8YS/Qo9vAMnI0TvduTB6e7CmaqW783XfVJsvnRaLz4YA0UojEy5TyppyuDncG4ojG0dyThGkVL
	qjPZIRt/k9yCchRQtfsaomn84gOQFfBuMDPiKW4Jb56p72opg2pMQrXc6HhZuooywxuUDkfW8ed
	tH+NIHgTj9noOn2PHJI5GNI98HLr2Kc+LCP/5zSYk+C7+p0Fele5dJOrmKnazzbwtgRRWbmTgkz
	0s2ZZC7FxxBGZE9k8yJUJ+GcWqZQ=
X-Google-Smtp-Source: AGHT+IG1cQ8gEUmyj6oYm0420F/CcVaCZVa/Cgkkgo1hO0M+BzfKwoIAThBdO9v73bPtWuE/F8dgnw==
X-Received: by 2002:a05:6512:68f:b0:55f:4ef2:7c8a with SMTP id 2adb3069b0e04-5626256fe4emr3585693e87.46.1757452360663;
        Tue, 09 Sep 2025 14:12:40 -0700 (PDT)
Received: from [192.168.1.243] ([143.58.192.81])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5680c424fc9sm757025e87.9.2025.09.09.14.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 14:12:40 -0700 (PDT)
From: Andre Carvalho <asantostc@gmail.com>
Subject: [PATCH net-next 0/5] netconsole: support automatic target recovery
Date: Tue, 09 Sep 2025 22:12:11 +0100
Message-Id: <20250909-netcons-retrigger-v1-0-3aea904926cf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACuYwGgC/x2MQQqAIBAAvxJ7TrColL4SHcxW24vGKhFEf2/pO
 DAzDxRkwgJz8wDjRYVyEujaBvzhUkRFuzD0uh+17SaVsPqcimKsTDEiKzeEcTBb8HYyIN3JGOj
 +nwuILsldYX3fDxe4L35tAAAA
X-Change-ID: 20250816-netcons-retrigger-a4f547bfc867
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757452359; l=1082;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=ezTZdY1rg6AngguOp9RzeNdcL1r5kQPAjVb8c/OH8V8=;
 b=dT1/OcdYuEeI2E/5E7HBUkx4Mtd8RHB6KB8xG+JZ8DEyLFUUlHEQW3vqVMS+gwzXv8qYJDsC1
 EWefx1Hh4INDvEd4rU0a8CgP0OcRJ47Urnx807KUVapEQi++ZUKYSsA
X-Developer-Key: i=asantostc@gmail.com; a=ed25519;
 pk=eWre+RwFHCxkiaQrZLsjC67mZ/pZnzSM/f7/+yFXY4Q=

This patch series introduces target resume capability to netconsole
allowing it to recover targets when underlying low-level interface comes
back online.

Signed-off-by: Andre Carvalho <asantostc@gmail.com>
---
Andre Carvalho (3):
      netconsole: convert 'enabled' flag to enum for clearer state management
      netconsole: resume previously deactivated target
      selftests: netconsole: validate target reactivation

Breno Leitao (2):
      netconsole: add target_state enum
      netconsole: add STATE_DEACTIVATED to track targets disabled by low level

 drivers/net/netconsole.c                           | 110 ++++++++++++++++-----
 tools/testing/selftests/drivers/net/Makefile       |   1 +
 .../selftests/drivers/net/lib/sh/lib_netcons.sh    |  23 +++++
 .../selftests/drivers/net/netcons_resume.sh        |  68 +++++++++++++
 4 files changed, 175 insertions(+), 27 deletions(-)
---
base-commit: 3b4296f5893d3a4e19edfc3800cb79381095e55f
change-id: 20250816-netcons-retrigger-a4f547bfc867

Best regards,
-- 
Andre Carvalho <asantostc@gmail.com>


