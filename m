Return-Path: <linux-kselftest+bounces-20413-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4829AB5FE
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 20:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24338285128
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 18:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06307194AFE;
	Tue, 22 Oct 2024 18:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YTn1tJu5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFC317C98;
	Tue, 22 Oct 2024 18:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729621865; cv=none; b=q6JZpxDgTvwmS5KNmz9JSVTr9wdTYa7UC3/TSywa1ltaULy//gqSqOTJiHrF5nUFu99eg6x2yJ575Ts1Wt5J+/VnlHzpkvDGOEehKpZlx7ORdRfhuzJ6SEbSITECSeNrvDX6OslSVleUpdt0HE5eJcxf7M9neCwusag9zoV8YII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729621865; c=relaxed/simple;
	bh=xTb8QwlkDrFvVCaS/iISwDtl8ozTXuI+iQ6WbjUmlVo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZOfiItdMGWfAei/YQXGY9YNaWRKTMToqpdW+CsKSI8F3qk8W88GZD1bw3jNFnT0NW9Qw1VshvoVHlMR6LdIPjTgTI3nbBf5i/OtuRONrhHyk6b2pf0LDEzfTK/GrR6NVIppacMrKJqyFYD8Ahozx0FvqSHKi/NlkJ1w8l80V/pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YTn1tJu5; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20c6f492d2dso69023215ad.0;
        Tue, 22 Oct 2024 11:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729621863; x=1730226663; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tnQ7+rCkZXbyztDomRcRBcbYj2/yEVcOEKxWmvn0n34=;
        b=YTn1tJu5/p18yZhU8Vc76cuJ123E0xlg+mTGUQoiltgXFXtGHcxkDfYdzJ3yhNDLwZ
         ABRPffoKPT2mFHqeqtSwHZfnQD6hlzuE3viMguQHNEdKxTbCMlvV6S0Qnn2EhOhTw3rc
         6jAw9s2XvMHtnPdejFu2t+JL4Czj84dr0GuLda3yQRCFsuqc7vXYygkLHa6hLlyhr26b
         vjeZvDp1cJwagRe4hrSVJi3KN6MxLixhkFshVlWGuygUICe0w8ONVk+OQZvbV6cp4zFN
         T7fGSQuNQz7POy9t+Q9pcxzH1Hv+DPup9+9d1N/P2Vkfbuyod4pOJraR7kd3yWd6Bbaj
         xddw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729621863; x=1730226663;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tnQ7+rCkZXbyztDomRcRBcbYj2/yEVcOEKxWmvn0n34=;
        b=Oga2IBzlRLkZTa7Ibg2LTGpJhk1eLwStl3aKSpVz8kl0MFPv0le2J+PpMyvSP9pjI/
         YubW58OND1VzLkEeWnpsCor/jgcmW2X2jqI6agZaXuj1qAI6GNhz7j1vx555cK5mq2/r
         XKXLegzDsJC+nxSluIGh+gexdMbz3I9DwK4WUa50CCNMuT1WRe70pri9CU5iPyY/lGb8
         s/XTMwKmNgQScF4HxVkrnb6p7zlSimImB0P3aRUl5lrKIlddOqez8izew5PPK4JR1bmO
         d3DYBLJu9jh2ZyVMVkHImIVEmrm3V7QjcxCbcfE1ABghh+JXFS5RNl/eBHmEhpo2Uv+6
         WrTA==
X-Forwarded-Encrypted: i=1; AJvYcCWF3kfa0FZSBjxuW6ooUkyxbz0xqaKkktq/nKtpS2WkgKEygz1/q13dLOjcagA6OKUzeizmVS+5PzTzs/c=@vger.kernel.org, AJvYcCX7PDMbi3s4ibbyv5fFE4Gj3Ln1iNSAwVAfxaQoQuYqqMvAecsJxdHdk4ftNjgHunrKEuRY5/Ke/vLzwGmxFj5L@vger.kernel.org
X-Gm-Message-State: AOJu0YxnyTrat1hbu4D+smwkIAZWPGFRHeYTdm1PQVJoANlbJ8SRUjZV
	QQpGlmcqwryFUFD9XPvasuo3UbmEE7paq1IaWjjLIJveRQOx80mv
X-Google-Smtp-Source: AGHT+IHNdIPSmh+KeUexo2AeMR5Kp5A3TMqBsgaSE6HwpIK/uR5kOZ2/kuoHeRlJKRjEZO2vxBLvJw==
X-Received: by 2002:a17:902:ce10:b0:20c:8cc4:cf2c with SMTP id d9443c01a7336-20fa9deaa57mr880345ad.10.1729621863301;
        Tue, 22 Oct 2024 11:31:03 -0700 (PDT)
Received: from Emma ([2401:4900:1c96:850b:5054:ff:fe53:2787])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0db968sm45380775ad.200.2024.10.22.11.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 11:31:02 -0700 (PDT)
From: Karan Sanghavi <karansanghvi98@gmail.com>
Date: Tue, 22 Oct 2024 18:30:52 +0000
Subject: [PATCH v2] selftests: tc-testing: Fix typo error
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241022-multiple_spell_error-v2-1-7e5036506fe5@gmail.com>
X-B4-Tracking: v=1; b=H4sIAFvvF2cC/22NwQ6CMBBEf4Xs2RpaEZST/2EIKXULmxRKtkg0p
 P9uJfHm3N4k82aDgEwYoM42YFwpkJ8SqEMGZtBTj4IeiUHlqpC5rMT4dAvNDtswo3MtMnsWl06
 VlU3BooI0nRktvXbtvUk8UFg8v/eXVX7bn/D6X7hKIYXVxtri1J1Lmd/6UZM7Gj9CE2P8AJkyv
 Ny4AAAA
To: Jamal Hadi Salim <jhs@mojatatu.com>, 
 Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>, 
 Anup <anupnewsmail@gmail.com>, Karan Sanghavi <karansanghvi98@gmail.com>, 
 Simon Horman <horms@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729621860; l=4633;
 i=karansanghvi98@gmail.com; s=20241017; h=from:subject:message-id;
 bh=xTb8QwlkDrFvVCaS/iISwDtl8ozTXuI+iQ6WbjUmlVo=;
 b=Sq6UjlXOKPGlyDZunQuNtchlMv7Y9txwG1Hic9eSLsNzhN627SeyJ0KOOIvj8PLqyppw+Q+2Q
 OxYSwVKjAkrATQte18MS/J3qA0F7R2C+HFx+IBVg8YR5rP/TIizYU3V
X-Developer-Key: i=karansanghvi98@gmail.com; a=ed25519;
 pk=UAcbefT1C06npNVDJHdgpPqTm4WE9IhaA1fmJb3A37Y=

Correct the typo errors in json files

- "diffferent" is corrected to "different".
- "muliple" and "miltiple" is corrected to "multiple".

Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Karan Sanghavi <karansanghvi98@gmail.com>
---
Changes in v2:
- Rewrote short log and commit message
- Link to v1: https://lore.kernel.org/r/20241019-multiple_spell_error-v1-1-facff43b5610@gmail.com
---
 tools/testing/selftests/tc-testing/tc-tests/filters/basic.json  | 6 +++---
 tools/testing/selftests/tc-testing/tc-tests/filters/cgroup.json | 6 +++---
 tools/testing/selftests/tc-testing/tc-tests/filters/flow.json   | 2 +-
 tools/testing/selftests/tc-testing/tc-tests/filters/route.json  | 2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/filters/basic.json b/tools/testing/selftests/tc-testing/tc-tests/filters/basic.json
index d1278de8ebc3..c9309a44a87e 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/filters/basic.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/filters/basic.json
@@ -67,7 +67,7 @@
     },
     {
         "id": "4943",
-        "name": "Add basic filter with cmp ematch u32/link layer and miltiple actions",
+        "name": "Add basic filter with cmp ematch u32/link layer and multiple actions",
         "category": [
             "filter",
             "basic"
@@ -155,7 +155,7 @@
     },
     {
         "id": "32d8",
-        "name": "Add basic filter with cmp ematch u32/network layer and miltiple actions",
+        "name": "Add basic filter with cmp ematch u32/network layer and multiple actions",
         "category": [
             "filter",
             "basic"
@@ -243,7 +243,7 @@
     },
     {
         "id": "62d7",
-        "name": "Add basic filter with cmp ematch u32/transport layer and miltiple actions",
+        "name": "Add basic filter with cmp ematch u32/transport layer and multiple actions",
         "category": [
             "filter",
             "basic"
diff --git a/tools/testing/selftests/tc-testing/tc-tests/filters/cgroup.json b/tools/testing/selftests/tc-testing/tc-tests/filters/cgroup.json
index 03723cf84379..35c9a7dbe1c4 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/filters/cgroup.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/filters/cgroup.json
@@ -67,7 +67,7 @@
     },
     {
         "id": "0234",
-        "name": "Add cgroup filter with cmp ematch u32/link layer and miltiple actions",
+        "name": "Add cgroup filter with cmp ematch u32/link layer and multiple actions",
         "category": [
             "filter",
             "cgroup"
@@ -155,7 +155,7 @@
     },
     {
         "id": "2733",
-        "name": "Add cgroup filter with cmp ematch u32/network layer and miltiple actions",
+        "name": "Add cgroup filter with cmp ematch u32/network layer and multiple actions",
         "category": [
             "filter",
             "cgroup"
@@ -1189,7 +1189,7 @@
     },
     {
         "id": "4319",
-        "name": "Replace cgroup filter with diffferent match",
+        "name": "Replace cgroup filter with different match",
         "category": [
             "filter",
             "cgroup"
diff --git a/tools/testing/selftests/tc-testing/tc-tests/filters/flow.json b/tools/testing/selftests/tc-testing/tc-tests/filters/flow.json
index 58189327f644..996448afe31b 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/filters/flow.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/filters/flow.json
@@ -507,7 +507,7 @@
     },
     {
         "id": "4341",
-        "name": "Add flow filter with muliple ops",
+        "name": "Add flow filter with multiple ops",
         "category": [
             "filter",
             "flow"
diff --git a/tools/testing/selftests/tc-testing/tc-tests/filters/route.json b/tools/testing/selftests/tc-testing/tc-tests/filters/route.json
index 8d8de8f65aef..05cedca67cca 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/filters/route.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/filters/route.json
@@ -111,7 +111,7 @@
     },
     {
         "id": "7994",
-        "name": "Add route filter with miltiple actions",
+        "name": "Add route filter with multiple actions",
         "category": [
             "filter",
             "route"

---
base-commit: 8e929cb546ee42c9a61d24fae60605e9e3192354
change-id: 20241017-multiple_spell_error-8b267ffffe47

Best regards,
-- 
Karan Sanghavi <karansanghvi98@gmail.com>


