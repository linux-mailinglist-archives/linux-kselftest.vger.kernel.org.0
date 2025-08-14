Return-Path: <linux-kselftest+bounces-38922-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC444B258E1
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 03:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 098AB1C216E5
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 01:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7613316CD33;
	Thu, 14 Aug 2025 01:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WoX7AG+k"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AFB12F5A5;
	Thu, 14 Aug 2025 01:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755134456; cv=none; b=ZnqbtTEmRhFpkAK75EcDueoFzLh4J24+B0hMV/ZjLRTqPYmER336NjeyzGHzzB+r4OjRldMGn9bSbhvMFAFlPebUZ+V9YWA6SS0UAW04UjhlrYzYoeWHxRYgEWNMCLGgbFjp1JMwf9SVaQn6kYveYcKXh/mZXba04LgAiVTaW48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755134456; c=relaxed/simple;
	bh=xuXec0vNgnMrOGkKbUiODZFYAEqOMJ7nf4q3Q6ncR8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aCarHSVSHy7vU9HyInxzttES5dwczPnZUCuEY6bYHhsi+D9T9XaK5Hdbr5eSh1gbMdI0Ln97O1MS/+prq75Nna/CbHsxXu7bwbI4Igu5BYtX3eWuRtrZNk966lIXJrEWSzSYFRJgpI3i4aenINxJMe/wmADdJXpg2I8OlQWEIn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WoX7AG+k; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-24457f47000so3244245ad.0;
        Wed, 13 Aug 2025 18:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755134454; x=1755739254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J3cqJjsKgUfNQHIJGghY3tGnN26Swv5SE+XpWRbKNFE=;
        b=WoX7AG+k/a520FQj1KJFte5J7L+bZjvTRjiv1HqXdoEZUL9ZcFJu4JfPXFpmKY+6WZ
         vOpO+vLebHMhERbpaKO5Mg3W/Vzn+fnTRj/ptGMg2oLyriBnGn04BNBxigH/jFOAEuEj
         M56INF5bq1bGNxIMGbn0dNuD9t54Vs/1LQkA1mUTyQjzYEVj1LJqskY7NJgmZdrquTrH
         OsnwOAf2M67/F8Cvl8oVrhPqWH359hxkhSgTXlJfkuej2HSD4EtDM1LPPaZ89BhWmdUZ
         AmtIjOxmM4oIdCzx2lvRjPmtAhkrgjbE6ot4+ktm3w/CluYym9gwebsEzytj4lj0erQF
         V/0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755134454; x=1755739254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J3cqJjsKgUfNQHIJGghY3tGnN26Swv5SE+XpWRbKNFE=;
        b=mJU2dhCqiCax/aXdU2hlx0UFmVUFe7ILi4fe37aJvMUpgC5iuyBPF41wWuF3Zz+RTl
         k5EVP41dP3+JP21KjPEHHk7AYkwGo70MlzhZ3lCgu1o4vs7LEKIy46OhCIX0RtCRiLI7
         SAggOdZaG/TD3heZvSyy1YHg2y3lf52enemlCFj+S6gZNb3rY4aoXhlv0j+XveD7MEXb
         rPaieXgXLXXsCDUh18Xp3KlBjHcWQXINPc8xUL+o/oOkvScAHWoEqoNfSxuDanV6cgSl
         g1DDtUunKlWYjRtVjDeqGYN8Gd44xs3zAftP+DeVqpIFe3Ax2c1ahN8Br39hry6QoG/T
         fyHg==
X-Forwarded-Encrypted: i=1; AJvYcCUFXu3XC9N3P0SkdFug5+K9L4a0sIJVnwV5r97argLeHB4qYf6IN2sczcJmMeYs0rzomRS2sRzH4z1K@vger.kernel.org, AJvYcCV0kqkYGcEZH0PPWJuhMhYkH4ECquURxfBE9XBKx9SpcMxrCAYHK4SpfiJIqlSdQUekS4BMB44vz553uC4AixR4@vger.kernel.org, AJvYcCXkM91Fy/oz+Qw/DuT806l8/dBJrpyvI8pTOiQ4F3TaAMgayZb2shzTf0epl+NZKrGnWn0UpuFknAk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhzc8m4YB2FTS5FmOXmtG1dsOtuxIM5JQI+52i0cI5/PMtUME3
	L1tNzlWjAAfd8Mi2Ingiju0tUl7HWrTdD1Qyp/mGoF7uL/EAemxGcRkd
X-Gm-Gg: ASbGnctrqiaHSBW2/LsBJuGe7uXXaZhRsRqel6XgkmyeDJwcvykCxDnq6JiknxLRCtQ
	0JgRvZfgZT7KwspEv7CcmS2DDXLwFpDszceHwBcQoe/osLIrUO4Fyp4k4kLwubNkLzlTb7EQrwt
	GEzaTMwHKdbVnen8W6nbfLcsJOzzTZd/X2QQfb7iZUCGLIJKd9bpkLShjiGdrrZTq3/lJQ+p7Bd
	2W9KZVREj6+41WuKJ0IcHGFUGsmmkfd9w17S29y8KveoDPF6V1hjm4oTC4KSt7J9P2er7ryiPWz
	psrsQAo+hCSf4jfyeo4WhRtbSY5eYNVhfbPuOVhJFKv/SLOrFT6jN94ucCpQ8ESPlfpiiUdPrWv
	yxc2pS8SSCwBlXbMKSaMEuUKqLPgOFPuh
X-Google-Smtp-Source: AGHT+IG37hIYaf4kIMoA8W+G3+4vMQF4EyJICk0l4JUSm8Gn749aXw4b4WcSeuRrmNGT4Xpxneqrhw==
X-Received: by 2002:a17:903:4b2d:b0:242:9bbc:3647 with SMTP id d9443c01a7336-244586f26ecmr16090005ad.57.1755134454095;
        Wed, 13 Aug 2025 18:20:54 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f1ebc1sm335304225ad.67.2025.08.13.18.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 18:20:52 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 4A11F41384E8; Thu, 14 Aug 2025 08:20:50 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Kernel Workflows <workflows@vger.kernel.org>,
	Linux Kernel Selftests <linux-kselftest@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	David Gow <davidgow@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Tim Bird <Tim.Bird@sony.com>,
	Rae Moar <rmoar@google.com>
Subject: [PATCH 2/2] Documentation: ktap: Separate first bullet list items
Date: Thu, 14 Aug 2025 08:20:46 +0700
Message-ID: <20250814012046.21235-3-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814012046.21235-1-bagasdotme@gmail.com>
References: <20250814012046.21235-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1357; i=bagasdotme@gmail.com; h=from:subject; bh=xuXec0vNgnMrOGkKbUiODZFYAEqOMJ7nf4q3Q6ncR8k=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBlzLU5rWLo3RFyrsRI4fdyCKTNpcdnOmPdtEx60yF3ct X5b3+FrHaUsDGJcDLJiiiyTEvmaTu8yErnQvtYRZg4rE8gQBi5OAZiI+GaG/7H9pZObVZs+7vmx tH7m41d6zc8UT7/VfrtKnHP1h4Wn+uYx/Hd48Y5BaM3pW56/TNz9Y9jZ5ZTeBpZkLVdJMWb+Kd4 VzgoA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

The first bullet list items are shown in htmldocs output as combined
with previous paragraph due to missing blank line separator. Add it.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/dev-tools/ktap.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/dev-tools/ktap.rst b/Documentation/dev-tools/ktap.rst
index 54fac3d3bf7b05..a9810bed5fd4de 100644
--- a/Documentation/dev-tools/ktap.rst
+++ b/Documentation/dev-tools/ktap.rst
@@ -20,6 +20,7 @@ machine-readable, whereas the diagnostic data is unstructured and is there to
 aid human debugging.
 
 KTAP output is built from four different types of lines:
+
 - Version lines
 - Plan lines
 - Test case result lines
@@ -38,6 +39,7 @@ All KTAP-formatted results begin with a "version line" which specifies which
 version of the (K)TAP standard the result is compliant with.
 
 For example:
+
 - "KTAP version 1"
 - "TAP version 13"
 - "TAP version 14"
@@ -276,6 +278,7 @@ Example KTAP output
 This output defines the following hierarchy:
 
 A single test called "main_test", which fails, and has three subtests:
+
 - "example_test_1", which passes, and has one subtest:
 
    - "test_1", which passes, and outputs the diagnostic message "test_1: initializing test_1"
-- 
An old man doll... just what I always wanted! - Clara


