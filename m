Return-Path: <linux-kselftest+bounces-34839-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8489FAD7BBB
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 22:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94A63188507D
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 20:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E502E0B4B;
	Thu, 12 Jun 2025 20:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R1u9ex91"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883332D8782;
	Thu, 12 Jun 2025 20:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749758593; cv=none; b=nDVtLWEFdDuU/sZKm+1lfNNfLa9p0z/bKIyVtmGHPMeC2rB1Qp0ZeNKVfWIGz5JKm5k+AtPJXXTT5Cq82SeqZ2l9P8dguDxSAFHc10o+KLOzC8EZJtGpewJ6j5VdzyOyi6MnTjOk5kIMVFYw3Mk3Hmv6VoPmZ9meBz0Ailm8+Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749758593; c=relaxed/simple;
	bh=WIciPhkuwpytb96ZPY3/taNGW/mxm70/ocDf/etRYAY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=aMQpT1etPb7CKquTVfCLlpJqZXfOiqb1BtZ0Ti6NP/5gT0M7nqsK1iOVUDOZArJT9T+IjT3OdxwnTyfNmv0ihfNWMmEEmKe26IeohQJ+W3dwZwrfzPZ7wxZ1w/7E8GVTSz2FTDah9RlpqgoSZOn6ERcv8yasZx1f4x1tYdGVAXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R1u9ex91; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4a5901854e3so1979181cf.3;
        Thu, 12 Jun 2025 13:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749758590; x=1750363390; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xc6N+dUinlHw4NHSG2eKigRbuom9TvjgvsTWo0kWaOk=;
        b=R1u9ex913dDCt8MWvYVKqiLpUwHZlK1jNHSAA47qkTW1knj8vgkNS0ZXL3TN6eXepw
         JbpttQqV998JFsxk0yHZUr8pIccZFX+E9wjPXoKEX5JeeXtEzIi0bNFX3YNJlAdegPFp
         NSlLwtxvdEUW9Tentuu9zVrN4+rzc5ReZmGFP1S7xEXv0QtzGMTlLwkeMwRTwGw0/wD0
         /4c5ICwK+kNptOasVJMwwyYHRcuUFODs9iaKcD71DyCTSxd77i05uDQDzR5yUMS8prT8
         28U5dSy6K1OR1sGtOjt8xXvsPi0BtyspJO/ufyaWyZfHACtWDM9RzTOaXSi4eHFFvTgU
         XPOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749758590; x=1750363390;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xc6N+dUinlHw4NHSG2eKigRbuom9TvjgvsTWo0kWaOk=;
        b=mgWn1EOEFwtAN1N9YvsbCHlekBWl3nIPHezZHt/d77AwdYu4zaJq66mg4jLmXnGIbB
         mymlStHgWbj4yykpu0F6NQFRgvG5Slq9b2hZnSeXIF+nWUy373IXSLe3Ztzh8Blhn3JK
         XZUTZTqhO0ojoKR8d1ePiS1M0nfjz7C+HqmOAfNV/Il5LdQfXxG1ShevMWo6QHLnMmkp
         1bI94UKzbyhLMujIgQTtWx9GHTceH5qcYgygBSKN5ovXHUbwlM8CtlHGeITsVNFc/HGY
         OldbOYMnIKml457tzzcwrxe/lw7zXJeuQqMiUqJ1AY7N/7A/b2uwQyPWrxv7S8DE5uzJ
         NaAQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3YbDF0bSb2wwyAqNNiHYJbnGXf6D8zMPKeBfBTom3oeuNeVm9MPr8UhArRWE+JP1Chg6UtRHsBak9Ll/D@vger.kernel.org, AJvYcCVmFfinmb5Q6wUs1r2Urg+Wnp3gdgjGUn+EOmNuC5zHcdoXbuvMawIXbURxBAbnn/qgKPV2l22bXEU=@vger.kernel.org, AJvYcCXob5MS8c0l04a5WtoYA4RMlPAfM4oXqU4Wu3B7sm608me24OBXBX87ydypoy7L0bzTaHUsAE+qDpoTdZAmKz2R@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg1iGSrNFEQQL8nN6wj8Ptl8UJf3XTiu1lPDLEeY1wz4l+lFhH
	v7zddYoPYlbqEq6IBK126nj9v4OxvZ9IDRYddnIDHABlq04qop5kT7bZp1c3cZ9D
X-Gm-Gg: ASbGncsQraKRwvkEcDaCTMIvbb/3eQZtC6jk5fmN/ylXokmPuSRyAT77XsKbB761Oue
	HAAsOSZvG0ypKbfa5n/sRkBcz540a1JDcMpf7SclufQqLwA+NmsVxxFgBEaNXG4B4sR1jkDFeRi
	HbbHvrCWhVRx0KJmNIiM8tkHrqBqqcGUDH2Wy/1el6/auMVNy1JtznlmviHhV3uRRtodERPYFMK
	c4JTPDzrHUX8Yy3a22BtU6vOPeLMlkmqOJP1Mn5VbcTjMcQr55cky3L8yakk9yyoyF5C0YrMkXG
	ZkJa7KWgalgEh+ilEI7zANOMNyco8f7ef5tHTLp9LYEYcrU8PbkieTw=
X-Google-Smtp-Source: AGHT+IGh8hGn1isSQPrREYZv+mteO2JTk2LNLUhOGmq4qos4Tno+tEnXNR6Sbv760f4p4rKcB7Av/w==
X-Received: by 2002:a05:6214:1cc6:b0:6e8:f645:2639 with SMTP id 6a1803df08f44-6fb3e5ba9famr1175366d6.5.1749758590209;
        Thu, 12 Jun 2025 13:03:10 -0700 (PDT)
Received: from localhost ([2a03:2880:20ff:9::])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb35c31688sm13592516d6.80.2025.06.12.13.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 13:03:09 -0700 (PDT)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Subject: [PATCH net-next v2 0/5] netconsole: Add support for msgid in
 sysdata
Date: Thu, 12 Jun 2025 13:02:13 -0700
Message-Id: <20250612-netconsole-msgid-v2-0-d4c1abc84bac@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEUyS2gC/2WNwQqDMBBEf0X23JSsrVZ76n8UDzGuumASSUQs4
 r93scceh5n3ZodEkSnBM9sh0sqJg5eQXzKwo/EDKe4kQ67zQpe6Vp4WG3wKEymXBu5UW99s2Vd
 U21KDYHOknrdT+QZZC7Et0EgzclpC/JxfK579T4v4r11RaYWP6m4K7KlFeg3O8HS1wUFzHMcXH
 bMMbLoAAAA=
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
 Gustavo Luiz Duarte <gustavold@gmail.com>
X-Mailer: b4 0.13.0

This patch series introduces a new feature to netconsole which allows
appending a message ID to the userdata dictionary.

If the msgid feature is enabled, the message ID is built from a per-target 32
bit counter that is incremented and appended to every message sent to the target.

Example::
  echo 1 > "/sys/kernel/config/netconsole/cmdline0/userdata/msgid_enabled"
  echo "This is message #1" > /dev/kmsg
  echo "This is message #2" > /dev/kmsg
  13,434,54928466,-;This is message #1
   msgid=1
  13,435,54934019,-;This is message #2
   msgid=2

This feature can be used by the target to detect if messages were dropped or
reordered before reaching the target. This allows system administrators to
assess the reliability of their netconsole pipeline and detect loss of messages
due to network contention or temporary unavailability.

Suggested-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>

---
Changes in v2:
- Use wrapping_assign_add() to avoid warnings in UBSAN and friends.
- Improve documentation to clarify wrapping and distinguish msgid from sequnum.
- Rebase and fix conflict in prepare_extradata().
- Link to v1: https://lore.kernel.org/r/20250611-netconsole-msgid-v1-0-1784a51feb1e@gmail.com

---
Gustavo Luiz Duarte (5):
      netconsole: introduce 'msgid' as a new sysdata field
      netconsole: implement configfs for msgid_enabled
      netconsole: append msgid to sysdata
      selftests: netconsole: Add tests for 'msgid' feature in sysdata
      docs: netconsole: document msgid feature

 Documentation/networking/netconsole.rst            | 32 +++++++++++
 drivers/net/netconsole.c                           | 65 ++++++++++++++++++++++
 .../selftests/drivers/net/netcons_sysdata.sh       | 30 ++++++++++
 3 files changed, 127 insertions(+)
---
base-commit: 535de528015b56e34a40a8e1eb1629fadf809a84
change-id: 20250609-netconsole-msgid-b93c6f8e9c60

Best regards,
-- 
Gustavo Luiz Duarte <gustavold@gmail.com>


