Return-Path: <linux-kselftest+bounces-44271-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7867AC1914A
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 09:36:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AED9C1C859CE
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 08:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393B331A81B;
	Wed, 29 Oct 2025 08:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L13SktAy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9442731A7F3
	for <linux-kselftest@vger.kernel.org>; Wed, 29 Oct 2025 08:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761726185; cv=none; b=u09ya0Zl/ENYd6wX8LobTA5EPCB+HzUogfKuS/FFqdFSavSDlMbEnefpUJVZ/fK9lkXeSUxl/IgdQly9PIGUBwYLk0MPioeAaJ02Qog8KFeeaq/mt3eSlE3hcTcz0yAMRYyKS9jrHkEPtY1ruYp/8Qe5AHLFSotxHy9DAK2SN+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761726185; c=relaxed/simple;
	bh=utVy6JvlKERgKujYhOgnVpCTFIWZ2va0wC2CkiqbEWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GzGrrsx5yom8gQ7sgdXw1i6HAxicXkTSFdFaFueeznpw6pAea5mA/GTGQtH4xaxuXa8dGDYc2HSjYR/cCBtUm6dfG1UWurh5yqSOz5SQa/DmMPctW0f7FLrqsaWoz72uJcD3NL+zA3iyytqZXr4aUCEdvpswTuK+0OEX5y6IJVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L13SktAy; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-290ab379d48so65341255ad.2
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Oct 2025 01:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761726183; x=1762330983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=za7hYkkLPLqSVT9uZfocsnw3yWLzRulvJUyGOCLkCKY=;
        b=L13SktAyCHfKdAyKlRiuooXieBpv6wayTeNRFob0aYzBgir8FcLsTd3mZI1pJt84Z+
         ioiKiVTSZqRFjOcgjZG306hH139i8Pwqe3tvs2rqRSneboUCRp0QlUrq+tFZsUBvrMnO
         J6bomQ1zYJSUc79e/tXNpuncK2C3RvrRH9YF1a8Ea6rJbFYGrXktqG/XXb3CSDUkRgI6
         2lBgBv4LrYYV9LWibtYeEfmC+RfMNzBzUOEXlODZAQ7diGMNIos+5s8qyQ0sDaTHatsk
         LL3j2VbDBcWKe7xVtFVP20dNPcZb6Vi8ZOnrHYTS2xxIef2UlV4yzPJM29FivK2QIcKb
         +75Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761726183; x=1762330983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=za7hYkkLPLqSVT9uZfocsnw3yWLzRulvJUyGOCLkCKY=;
        b=wBmWwK9F7FuS0Tlr1r9aMbYx3Riy4AK029h8RbPxkCSQ06ky/7Flfz1gqDytsQGiom
         0T3SDthGfCJfOENyv/KE5PlLAc7Qie9yIQdGzVlRe+wHa7iA5OxTagszAZubonw1xDSt
         73Gq8KuDmIXX29KoshO70ITdAVuK86c7YzYcw2Fx4ahLPCyPFBQXs+VaP3JvrSjv37Rm
         PZZAguMvNadHEuvjoqlWXoJlQGRQkymAD5IllWT7KxfQ3I4mfSY1tv2ZIIW42XF321sz
         LxJ8beYqqTJHvB+cwl0SiTVF/t0Ws/ZkLbLnrMHaCEKSoO8v8LCNAiEjZLV2Tm0JoGRl
         wfBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeg2nRfkdO1wslhQjBNokdoEtGGFhR+eD+UcUhjsslaEgn1I3QELlwOK8iKSI4Hz6yisWf48c/t+tW4mdqd04=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3IXk7NHvvJ3xBr2gfPMytjBNnnwl3PXNBCCqSDy8M51nTICSZ
	CJIgpZk/isx4KKLe/5kjjq1jl1yAslGSpABkV1puWtK4DtqP2qIA5KFE
X-Gm-Gg: ASbGnctpfhC28TmhNpoucqWp8TwSO5kakTLeE7Q9+dCbFX1z5Oxv0ovar4VDNHN8mgx
	rfqn62PFVcrGqBfUjwKVr8aKGWEvwv6Z3ENHJzsrgbSmScWFMqyI/BdCZi15Wtoj4F/ykGBoHum
	Wh+lnCKY6qCTpD89K6DNFAS8+aH2jY6LHwhtFohOpAbSj1WglMu4xF0EauW10Usy5fiZZVWMIho
	doILkhcnz89wFaZVyOUh7Dkdm9A5nRCFykPSihDbhGdCSPGVypyjj1dS/MLKY0WUElAKqFWIKjA
	W+jAn7QqncGSbE+a/3JgQ1eSL1a0K3lfj+Q4NgL171J5ejcE51wkSmjmZI8U8K2VN6VGiMZ7vt0
	XTktgGp2v4XFx8jbvm4n9FyBkacmYI7Q26mM1eS8A24c4JObJDJtBiWIO8+g+vw7e5CIKwIOiZr
	IlmEMXagij76wstyc=
X-Google-Smtp-Source: AGHT+IELDLicKMzwVGPxSzunKaHjKZ5b7HNcUcQ44DbmU71BO4kqKnfk4QDr6sZzaqPuCrB5RxEsvw==
X-Received: by 2002:a17:903:3d0d:b0:290:78b2:675 with SMTP id d9443c01a7336-294def46d76mr24636355ad.41.1761726182753;
        Wed, 29 Oct 2025 01:23:02 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d09958sm141906005ad.24.2025.10.29.01.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 01:23:02 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jan Stancek <jstancek@redhat.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	=?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Shuah Khan <shuah@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Guillaume Nault <gnault@redhat.com>,
	Petr Machata <petrm@nvidia.com>,
	linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next 1/3] tools: ynl: Add MAC address parsing support
Date: Wed, 29 Oct 2025 08:22:43 +0000
Message-ID: <20251029082245.128675-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251029082245.128675-1-liuhangbin@gmail.com>
References: <20251029082245.128675-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing support for parsing MAC addresses when display_hint is 'mac'
in the YNL library. This enables YNL CLI to accept MAC address strings
for attributes like lladdr in rt-neigh operations.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/net/ynl/pyynl/lib/ynl.py | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/net/ynl/pyynl/lib/ynl.py b/tools/net/ynl/pyynl/lib/ynl.py
index 225baad3c8f8..36d36eb7e3b8 100644
--- a/tools/net/ynl/pyynl/lib/ynl.py
+++ b/tools/net/ynl/pyynl/lib/ynl.py
@@ -985,6 +985,15 @@ class YnlFamily(SpecFamily):
                 raw = bytes.fromhex(string)
             else:
                 raw = int(string, 16)
+        elif attr_spec.display_hint == 'mac':
+            # Parse MAC address in format "00:11:22:33:44:55" or "001122334455"
+            if ':' in string:
+                mac_bytes = [int(x, 16) for x in string.split(':')]
+            else:
+                if len(string) % 2 != 0:
+                    raise Exception(f"Invalid MAC address format: {string}")
+                mac_bytes = [int(string[i:i+2], 16) for i in range(0, len(string), 2)]
+            raw = bytes(mac_bytes)
         else:
             raise Exception(f"Display hint '{attr_spec.display_hint}' not implemented"
                             f" when parsing '{attr_spec['name']}'")
-- 
2.50.1


