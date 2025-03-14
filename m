Return-Path: <linux-kselftest+bounces-29063-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFF0A618DC
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 19:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FC711B62F0E
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 18:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F95205ACE;
	Fri, 14 Mar 2025 18:00:00 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7693B204C3D;
	Fri, 14 Mar 2025 17:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741975200; cv=none; b=cHExpar5jnQIWwU65oMP+mmJRsYnKNXEkcGiB6irWigcEzI1bqV+XVke1WiBOxwUcBpYU+WGt/ip+Eghv9k496iR1qJwpdUYBxPZeUcg7+zsEz0hYINFXZRDOKbhjJBmhOEjSvukeu95BJsob0PIgGpb3BTlNiXzDaTL6AcdaWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741975200; c=relaxed/simple;
	bh=n7YLmPKcFzyiMGY19sL42wzgcPH5DaDlDb9GzN0V1Do=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cCEat1or/pQtF7FKcl3HfPcAvretqtvjnZmraJTA/9+5hNFfRnwXS0abg9tU0fyXoc9w2TJfOirSGZXlEueOa/Zn2DgUpxGtorscsl24TpqUzDrhzBiJaGV0BqfvXqyUanH8sfoQYyyAtrcy6JnC6YzAJpyzmv0I4jUHdFiTQ9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ac2a81e41e3so517039266b.1;
        Fri, 14 Mar 2025 10:59:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741975196; x=1742579996;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LRuwy9RwiCwKukzO7yJkusNhn22YXKV9KVdTGuMVhAI=;
        b=aLZtUcL53G4p1yhiSXsBk25i/k/6a8c/x29XxzR8wAigXoN4ODXmul6Y3xraHiTVbR
         SkY9Eu51qgJZWKFt4ZTVpmxxNKG2qfNNFZvhPRlUnbcAz1TTgjcHP7hE2exlJa35H12d
         gXyMef3efh31K3XH3dB85llkRBkesld3YS33seOMhDhwOTj9a3WzjHNi3E+zmnTET3uX
         qJpJvvEfvQLDjX2mOCGQN187ut0G3QjGBfCOPQ0NdqfeJLAje9gHEhw0dkwy6R5lwu6e
         rr02wf6GhOq9qlVpWoIz0wzBznUhSNambtbYZwk8EsX7EDg23EZ6zzCxSdRXsvd7bKqS
         ki4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVRcSgEYW4ERKhbM0LsAiZTtqU2+DJgCAm2IDe+N6tdR65YPncC0fgcnhSHpf4ZHvqXWkDcW3mmRUXgeftT0fpX@vger.kernel.org, AJvYcCW3R1Iles7JDqwnTY9bHrLAWwTQBdBxPsYYwIoWJgk/hY7owhmvHptgeJEfa2SlC5vev/5qBSJfk2xLFzRU@vger.kernel.org, AJvYcCXgvPvdY+itIadQBO7AnsVbO7YYchH3lBjPyNF6aOagUQoVwaGQmjwcs0xzjGtHZ72cJm+C//R5F98=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYE/+Y09yXcLpwb3iWk1UdBJounfG9NOSE0EmQpQQGPUcgEITY
	pkVMrEPO4d2gTRr0oHauMW0QSEhdmYvvHSz8Z3xPROo0r4tlVlCF+sLUXA==
X-Gm-Gg: ASbGncuTLALA1TogDKZBQ4fqvXzde2nUzCePTWuagsCS6EQKCImppTDhVB0p2hKiRkp
	hIaJAhBQw1/2QXKzuc0gis8JyBiqB+WjCB0ILKSaa1/piCRvevJbd2B9lxmYZoW8sJT9E6DQluF
	LSq7S5Rxvk2H+oEEgCH09G3Qj8RO6+NEvREvaNBdsGFiHnXK4/yd8EJ01aPlggjykphGMLzvUIz
	XUGjIGBVpa6triPm9iu4+s5+DX52cqxDlGJUKjg8MwoDoKfzFpkNQTrzdHW0mwSEwpEh2zsvimb
	MTZrKkQ+qNVMDy0nepd6xMV8Z3NI7C5+2yP8
X-Google-Smtp-Source: AGHT+IHYtsX/skL+dGTCOLuiJxtx25JKkIFbmzmpjCz6CWGM6K/cB109Za+T4m8txU4x9C/Y4qDKqg==
X-Received: by 2002:a17:907:2ce1:b0:ac3:17bb:34fc with SMTP id a640c23a62f3a-ac33041cc4fmr372928466b.52.1741975195881;
        Fri, 14 Mar 2025 10:59:55 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:74::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3146aeb2fsm258576766b.15.2025.03.14.10.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 10:59:55 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 14 Mar 2025 10:58:48 -0700
Subject: [PATCH net-next 4/6] netconsole: append release to sysdata
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250314-netcons_release-v1-4-07979c4b86af@debian.org>
References: <20250314-netcons_release-v1-0-07979c4b86af@debian.org>
In-Reply-To: <20250314-netcons_release-v1-0-07979c4b86af@debian.org>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
 Manu Bretelle <chantr4@gmail.com>, kernel-team@meta.com
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=1406; i=leitao@debian.org;
 h=from:subject:message-id; bh=n7YLmPKcFzyiMGY19sL42wzgcPH5DaDlDb9GzN0V1Do=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBn1G6SeKx5oHF1VFRCXelhWesax/zFygsmYGBtT
 H8hy31AlUeJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ9RukgAKCRA1o5Of/Hh3
 bcdGD/9800VJ0IWU0Cq1DMcT7UBEm3XKtpuzBk1da8eN5GD5rzePLkzyEcWK6tRwo+auNbLnvQs
 WqSnnd2QGnUOePRgdmKNTxwwfBDC9NhtOyxy1KAXqACbMhcSQpvnvLiePLA2cnMIPWx6VJfPHPr
 YywLQcv5GMDOcNSffgGR9OSdDe0Z8v3wkXLtEQcJ/hd1NMML8k8EYHDw5rnMGH33456CfSAYOGf
 3FkKiNqBNpAGh1NyIxH9N6HcxoPQE6VvK5srN7iU6V3ntoy3ivEQGFyHiorNBSszCVmwWSzm2u7
 ObO8c5C8Tu+Cj8tVjQcJ8cl/HdS4e3eicgXBjo0Q+cPw0XLMnF729wbrYmKk3FQwP3ugLGRgYYG
 cA2Ir+K5J0AgXeZaL8yxe6jgdqVCo/kO1KCqnwDcFpBXdWQyD1zWZ+7AdrCo0W6p13Y1No/0+y1
 EblqldE7dJgFoyFIPmUlAeg5KQWS7hdlp2Z6/Uu6ZEGDmQ/3SxZesln/7hzCKmsVjIwkS+LHErV
 3t1evjYSUFRGJ0udFfsMJWulsWjMd5r5cbBLtD+fI1GLMC4rNkV0IfZPNRZmbHiIfRX+E9PyFxe
 sV/pL3GIMrmIRnPEsh9h6oo67Ht5wDTAH/ZGJYKb2gygK0f7Wn27Wb9qc/EeJ8ZzGB6y4w+mDfu
 SWUdFNL1cig7kHQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Append the init_utsname()->release to sysdata buffer before sending the
message in case the feature is set.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 970dfc3ac9d41..0a7981ef752c7 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1238,6 +1238,14 @@ static int sysdata_append_taskname(struct netconsole_target *nt, int offset)
 			 MAX_EXTRADATA_ENTRY_LEN, " taskname=%s\n",
 			 current->comm);
 }
+
+static int sysdata_append_release(struct netconsole_target *nt, int offset)
+{
+	return scnprintf(&nt->extradata_complete[offset],
+			 MAX_EXTRADATA_ENTRY_LEN, " release=%s\n",
+			 init_utsname()->release);
+}
+
 /*
  * prepare_extradata - append sysdata at extradata_complete in runtime
  * @nt: target to send message to
@@ -1259,6 +1267,8 @@ static int prepare_extradata(struct netconsole_target *nt)
 		extradata_len += sysdata_append_cpu_nr(nt, extradata_len);
 	if (nt->sysdata_fields & SYSDATA_TASKNAME)
 		extradata_len += sysdata_append_taskname(nt, extradata_len);
+	if (nt->sysdata_fields & SYSDATA_RELEASE)
+		extradata_len += sysdata_append_release(nt, extradata_len);
 
 	WARN_ON_ONCE(extradata_len >
 		     MAX_EXTRADATA_ENTRY_LEN * MAX_EXTRADATA_ITEMS);

-- 
2.47.1


