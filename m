Return-Path: <linux-kselftest+bounces-22832-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B10AC9E4386
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2024 19:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0681B3F9DD
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2024 16:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CA620CCC7;
	Wed,  4 Dec 2024 16:40:59 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB3820C495;
	Wed,  4 Dec 2024 16:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733330459; cv=none; b=t5CGZQppXwfT0SbJ2I0OXBcZ0bjj+J5VcSaJ2CzVKInGVWb1+MZDWiDSzoVLAjDDUQesVowGYYuluB3kG5+SUFXndePsPfOFm9ySFJVFOibu8CQ1neAEW3rUV1+ayyrF4A7w7OcTFsdbzoXGJrkVba8WjnBpw1mufPyUGr331d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733330459; c=relaxed/simple;
	bh=Xha4eXVpUaFOpIZM+gMqYJIFFrsc90xcYMs1JxfcFNE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MoyfHomeXdOXjt67YX7qxUYkClaZ9P6Cf68heZxW2FgAJ4uhIgIfvc7eY2rSu1aFTf1Z0J1a3KxWCG25X8rhTDG89n3IEtISaba3W1cINCI9/ScRned/Ct54qOrf6FAOFt5dA3YB6OaIsmTbz0Q/OqyFI03zVAIQxAvIP1aWogE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5d10f713ef0so2015931a12.0;
        Wed, 04 Dec 2024 08:40:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733330456; x=1733935256;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=56y0WHQygoJxKLz73cSLHjJUjh4rvdzp/ejobPicFUg=;
        b=PsiesYc7aKIU2qG1oIYWUchaVgCLSQ8UpLZcl9oB8qyFvbTEfDkfK2quOc6IAMPHfP
         p91gybTKN05GnZ2B4evrMQO3fTsr0neWiwP2oRCe0Gj27qPbif+IKs6nwD956l4TkmT1
         xueJZ/YqYZHCZNwC8RwX8iCNPXsE5YlW6K/Ko8+ukOVD7r0woLuK978XAll3TcHgMHAj
         LMllSui5olKwhXB2p/G0PDUj+kmeK9E73VAhZciN/KGAqVu7f7zfWYdYW83Xogndz1wx
         B3yLCTkTXezjrj2iW0WwT4TWg09UH6lTR7HQnq4sVWslsydyfY5r2pFvPE4HIrZYNxcu
         idpQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6TLyT4QFwM6ZpP5pCZ9Gab3SFdLJ+IQXaascXKzwKgt13bO55iaEHzJumxqdM5g7zEeDeFdlh6wJfXPT06g7O@vger.kernel.org, AJvYcCXM2XhclioTbRH8ADcqFljN3XVr6MOv+jVj06ymj5aWlA8bTZINtU34mXgvYRLSK1mgaLuHp5EQ1+yl6c8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/x6PbnGmfM1Yiq0b4eDsDFOD5z5+ihM9j11cCIxFWlKMh/juh
	Jfaky1TlVGPlZYKHsQtvZGwJGqhfTRL1NoAF+QVqUGskqBX/l2kh
X-Gm-Gg: ASbGncv9fPpnOG0QlEc9gthx76bL+nTq4b53cMrpwAtDHt0VAjrtgJ3+kgVQ3WDcywS
	l+2gm+MUS1TriWlegHGeWaA3iTEWptpagridpVYU66oYFw+yKCybTQyGQOt59xV5/XQOM4cIYih
	0DNXrGkvo9B9Gn1uDg4Whwb8yfHkCJwJOdzlsslyn+h669ZDEBujKMc4DlCB0SVDpesQd1xG+6J
	vWdJMTCBiGMXLArp9S2WAGAK1niikJZLgZjnpn2keNLYTOx6gwC+gMscphiYJykcdfUfSYaQFmN
	HA==
X-Google-Smtp-Source: AGHT+IE/4y75vrQKRWn94IKE1t5FTBozjTLCOJzSNbJakBWdOec61xjF2X3+LosHYQPVGiQVRTK3Ig==
X-Received: by 2002:a17:907:96a5:b0:aa5:b1e3:c819 with SMTP id a640c23a62f3a-aa6219df3dbmr2002766b.22.1733330455562;
        Wed, 04 Dec 2024 08:40:55 -0800 (PST)
Received: from localhost (fwdproxy-lla-009.fbsv.net. [2a03:2880:30ff:9::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa599903e6esm750284966b.136.2024.12.04.08.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 08:40:54 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next 0/4] netconsole: selftest for userdata overflow
Date: Wed, 04 Dec 2024 08:40:41 -0800
Message-Id: <20241204-netcons_overflow_test-v1-0-a85a8d0ace21@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAmGUGcC/x3MUQqDMBAFwKuE923AxIiQq5Qioi81UDYlG6wg3
 r3QOcBcUNZMRTQXKo+suQiicZ3Bui/yos0booHvfXC+D1bY1iI6l4M1vct3btRmuaRpGDeXpjC
 gM/hUpnz+3weEzQrPhud9/wD/O/MXcQAAAA==
X-Change-ID: 20241204-netcons_overflow_test-eaf735d1f743
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1366; i=leitao@debian.org;
 h=from:subject:message-id; bh=Xha4eXVpUaFOpIZM+gMqYJIFFrsc90xcYMs1JxfcFNE=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnUIYVTNJQ0KQooFmpNx3rm2ve1UgJhkNfTq79k
 6GFNUeqUv+JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ1CGFQAKCRA1o5Of/Hh3
 bc/jD/9CB9oMeRkYz4rS8DfVThzwQZCbvxMF9ydzrVpsBXmzp15m1oYmva5S7iMV2vLKahH7Td6
 JGlbmsSBxUW9I61rMf60FgLiErDztJbSzOodnOLN8UI2mnBXj59y+pFm83FBJJx5NqqtR1DMsmp
 g416wKHbrY1qwHq2kEz44tIet8Lq4szXktNG4v+eZn3zTMmUavyemAZXpOaV80r6Zk4nkNykxjT
 V7kehNxplTdUxRYtyO4ugo+MZZCbn9+91WK+oC1LJquVYtFr5wOq3sVfNpmgWMtd4kpWtN07qxS
 FJegYHo2HcuwoPqR+Y5vX9ITeYXajrpYvc0bVKk/FnWEMeCjQq65ia5TEcJ5TJwCCWG1kTUA5v2
 NR7LC2OSfks4/Ajd44cGj8EIp4tCXIMb+Ixln/hD7dw4sL93jM8THlD4lAXYXYIxjP6/WLjxgE8
 oW+zg+AYLM5gbnc3sq5kKRKH2or7tBJY68wYNM9lwSt+pbU3WINTnp67mvFH7F8ZCzutzHRNeY2
 K+gbzDLxd74f7kbs7lLuDPZRLtE5cXvOpJgoEcAXx4q/Jxrlm7tykgHCvkYBe+4JzTvHGpE4g7M
 ZhmbFmLFQtobIzWvI8IRnFEu3gwyezVRDBnm8r0BZGg2C+6UrekSPuObL8POgI5xeUTl+nUkMuA
 EvfXkWEey/2xavQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Implement comprehensive testing for netconsole userdata entry handling,
demonstrating correct behavior when creating maximum entries and
preventing unauthorized overflow.

Refactor existing test infrastructure to support modular, reusable
helper functions that validate strict entry limit enforcement.

Also, add a warning if update_userdata() sees more than
MAX_USERDATA_ITEMS entries. This shouldn't happen and it is a bug that
shouldn't be silently ignored.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Breno Leitao (4):
      netconsole: Warn if MAX_USERDATA_ITEMS limit is exceeded
      netconsole: selftest: Split the helpers from the selftest
      netconsole: selftest: Delete all userdata keys
      netconsole: selftest: verify userdata entry limit

 MAINTAINERS                                        |   3 +-
 drivers/net/netconsole.c                           |   2 +-
 .../selftests/drivers/net/lib/sh/lib_netcons.sh    | 225 +++++++++++++++++++++
 .../testing/selftests/drivers/net/netcons_basic.sh | 218 +-------------------
 .../selftests/drivers/net/netcons_overflow.sh      |  67 ++++++
 5 files changed, 296 insertions(+), 219 deletions(-)
---
base-commit: bb18265c3aba92b91a1355609769f3e967b65dee
change-id: 20241204-netcons_overflow_test-eaf735d1f743

Best regards,
-- 
Breno Leitao <leitao@debian.org>


