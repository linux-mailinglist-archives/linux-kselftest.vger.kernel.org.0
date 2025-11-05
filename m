Return-Path: <linux-kselftest+bounces-44829-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 10EECC3710B
	for <lists+linux-kselftest@lfdr.de>; Wed, 05 Nov 2025 18:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 085714F83FB
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Nov 2025 17:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4EF33E341;
	Wed,  5 Nov 2025 17:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aYfmOXX5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD5423EA94
	for <linux-kselftest@vger.kernel.org>; Wed,  5 Nov 2025 17:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762362430; cv=none; b=NeS8k1FS/3nDYWH35/MV3HB7yPWodkylL9JBx87MfXe0FXjYbThE3mQ57r3l+j2ljGLWwJ4jxNKXaZiudvbgagIzw+rUdXZcJtgJpagpopVw1rRFG03WA2/T62Ct38SAdeqdoba1KX6GhbggQ9lYGrSvFZfCvcFHMYe01PHl0Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762362430; c=relaxed/simple;
	bh=vlDt8G7La6rBbMdsXh2EQ/UTfNoCsRjoqiLTl6V/5rw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B1eetiOUL0eJrIMsDH3+++O9QOs2NGbPw8tG/wVLje/mn+tmQ5vr3LeUFEZNrT7750rROVXkG0d7Y39+quur+O4ZhSIUter74cYsyjNIR0SCzYOb+zb88EW2496zzX4bcy6/NZXqxtOVsfdgftypaqj3aCSmq4QRdI4EHsEGUzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aYfmOXX5; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47714bb5c49so9785e9.2
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Nov 2025 09:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762362427; x=1762967227; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IyStgM1cwvNYi0rgpR5EPyADWjSnrMmQqly0Xyjd5fk=;
        b=aYfmOXX5G0SJ5qqGxFj6G3lngDY9pviWHuS1taLorV6Wc9wUQjogwvO1y6Jvrl8/Bw
         yQXptQib6stQy04bO0DNz5AuokiilTKEOb5GjjhWZi6d0mzBZoiVz/Y9J/4aomwIF5lx
         6Y2suJcmRVv4HPBd844d8rqzmtKyvtVesTAd2Mhax4DhUT6NxwjE1pbCkwCnx4+zKcaG
         RP7IGuO/VR/dEseK+Km4YmmpSrcfrS17lHs279A6biqpIJW3VPecvgxHWLjRSvX0OmQV
         PRlwht/tvFNhZKB+2GRnhO1ukhEOY86/eTZ1ixeRFnzfw2JuIXAtct4H9+WVpDN6S3Xg
         CyWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762362427; x=1762967227;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IyStgM1cwvNYi0rgpR5EPyADWjSnrMmQqly0Xyjd5fk=;
        b=m7wGMtUNxwiwTETYSfQnC2pRhLakz9y9ITIiXvgtubPrMzoeNnVmFmsua2P4w2SFnw
         shLGhaRGps99DVCusxZiK4dDrgd1S6cATCyYUYkQi5MG2fl5zI0r5y5dQLg7qh24o3tI
         5C27POVH27wodrK6C/a50x5V20NnHt2WcCIad53my72MKSvR7lRErq3+GQSNf+mWtykj
         EjhtfCDb55EDOZzZQKqLz+mO1dPKAhEqs7G6uR/gPYww2lrnrMkFgVAjfhFmhPXLqMdd
         9OWOSOrKk/al8qKplUp2yg5lVyAzOhH9F0CZ7jWwXAX+zmaeJYPKdhpMtYnFFHHC5MNb
         rWrg==
X-Forwarded-Encrypted: i=1; AJvYcCUt25hKy5hTlmwDzZFmOhZxlvoIkLydQqqZQh/cPlYq8Nib+eNKUpkwgaYi/PQRGpnn4mX2dL5tj7lWoxfZpZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPQUSh43crkQH1TuE/QQtE/qZdMi1cVQ31mQ6bI5siaDcBvBsK
	HEjJTdhWrWbElUrRJVP56VEVeU5o7wg0EDTYracmFZsDthGVbR/0Pv/U
X-Gm-Gg: ASbGncvvWHokIKnWhTV4y2QgtIvyO6Mq+Rvbb69RLa9yWtojNzSU/GGsjwPomWlVrZZ
	t2/MWhV56XjfDy6RWI4CExc2skSXka87gfvzpVXoPY5Sd0Ohky/IAdd7ueNyW/TvCkKMU0sM7at
	5dYJRt+7IX17Dfu9LvZoTLsFnZCDyxOhqEmeKQwTDNiqvq/IKU1CpT95oHGk4QLLx9tKtSlsYq7
	9ukppIk51TRds0zJ9K2iKAWlLokY5CVjH+X92y9fdvbuHBmDcBV8cnhkyf7D4Irn7yHPcrOCZc0
	q0xUXduDGND/avP4KcBfYUMh1ztOOOK8zfLNutF2pcgSQxVY9kmnQQ2PslSu659Bi11G2C2YlBJ
	TcMfnGcM7XCogxe98u1QTAksPNmj/aWdcOOnoyR/6P9DyxTMAur0PqqO2nduJpb1JYqPMpsyST5
	KK0dTM
X-Google-Smtp-Source: AGHT+IGO0uLduZurL5aiN3AILM28uZ4tKx7/MgWBJ8XXYSUROQlAHXvVRDNx5TsJBFuXRoics2RZRg==
X-Received: by 2002:a05:600c:46ce:b0:475:ddae:c4b5 with SMTP id 5b1f17b1804b1-4775ce16416mr18619705e9.4.1762362426572;
        Wed, 05 Nov 2025 09:07:06 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:4e::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc1f5ab9sm11179552f8f.22.2025.11.05.09.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 09:07:05 -0800 (PST)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Wed, 05 Nov 2025 09:06:43 -0800
Subject: [PATCH net-next 1/4] netconsole: Simplify send_fragmented_body()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-netconsole_dynamic_extradata-v1-1-142890bf4936@meta.com>
References: <20251105-netconsole_dynamic_extradata-v1-0-142890bf4936@meta.com>
In-Reply-To: <20251105-netconsole_dynamic_extradata-v1-0-142890bf4936@meta.com>
To: Breno Leitao <leitao@debian.org>, Andre Carvalho <asantostc@gmail.com>, 
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Gustavo Luiz Duarte <gustavold@gmail.com>
X-Mailer: b4 0.13.0

Refactor send_fragmented_body() to use separate offset tracking for
msgbody, and extradata instead of complex conditional logic.
The previous implementation used boolean flags and calculated offsets
which made the code harder to follow.

The new implementation maintains independent offset counters
(msgbody_offset, extradata_offset) and processes each section
sequentially, making the data flow more straightforward and the code
easier to maintain.

This is a preparatory refactoring with no functional changes, which will
allow easily splitting extradata_complete into separate userdata and
sysdata buffers in the next patch.

Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
---
 drivers/net/netconsole.c | 73 ++++++++++++++++--------------------------------
 1 file changed, 24 insertions(+), 49 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 5d8d0214786c..0a8ba7c4bc9d 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1553,13 +1553,16 @@ static void send_fragmented_body(struct netconsole_target *nt,
 				 const char *msgbody, int header_len,
 				 int msgbody_len, int extradata_len)
 {
-	int sent_extradata, preceding_bytes;
 	const char *extradata = NULL;
 	int body_len, offset = 0;
+	int extradata_offset = 0;
+	int msgbody_offset = 0;
 
 #ifdef CONFIG_NETCONSOLE_DYNAMIC
 	extradata = nt->extradata_complete;
 #endif
+	if (WARN_ON_ONCE(!extradata && extradata_len != 0))
+		return;
 
 	/* body_len represents the number of bytes that will be sent. This is
 	 * bigger than MAX_PRINT_CHUNK, thus, it will be split in multiple
@@ -1575,7 +1578,6 @@ static void send_fragmented_body(struct netconsole_target *nt,
 	 */
 	while (offset < body_len) {
 		int this_header = header_len;
-		bool msgbody_written = false;
 		int this_offset = 0;
 		int this_chunk = 0;
 
@@ -1584,55 +1586,28 @@ static void send_fragmented_body(struct netconsole_target *nt,
 					 ",ncfrag=%d/%d;", offset,
 					 body_len);
 
-		/* Not all msgbody data has been written yet */
-		if (offset < msgbody_len) {
-			this_chunk = min(msgbody_len - offset,
-					 MAX_PRINT_CHUNK - this_header);
-			if (WARN_ON_ONCE(this_chunk <= 0))
-				return;
-			memcpy(nt->buf + this_header, msgbody + offset,
-			       this_chunk);
-			this_offset += this_chunk;
-		}
-
-		/* msgbody was finally written, either in the previous
-		 * messages and/or in the current buf. Time to write
-		 * the extradata.
-		 */
-		msgbody_written |= offset + this_offset >= msgbody_len;
-
-		/* Msg body is fully written and there is pending extradata to
-		 * write, append extradata in this chunk
-		 */
-		if (msgbody_written && offset + this_offset < body_len) {
-			/* Track how much user data was already sent. First
-			 * time here, sent_userdata is zero
-			 */
-			sent_extradata = (offset + this_offset) - msgbody_len;
-			/* offset of bytes used in current buf */
-			preceding_bytes = this_chunk + this_header;
-
-			if (WARN_ON_ONCE(sent_extradata < 0))
-				return;
-
-			this_chunk = min(extradata_len - sent_extradata,
-					 MAX_PRINT_CHUNK - preceding_bytes);
-			if (WARN_ON_ONCE(this_chunk < 0))
-				/* this_chunk could be zero if all the previous
-				 * message used all the buffer. This is not a
-				 * problem, extradata will be sent in the next
-				 * iteration
-				 */
-				return;
-
-			memcpy(nt->buf + this_header + this_offset,
-			       extradata + sent_extradata,
-			       this_chunk);
-			this_offset += this_chunk;
-		}
+		/* write msgbody first */
+		this_chunk = min(msgbody_len - msgbody_offset,
+				 MAX_PRINT_CHUNK - this_header);
+		memcpy(nt->buf + this_header, msgbody + msgbody_offset,
+		       this_chunk);
+		msgbody_offset += this_chunk;
+		this_offset += this_chunk;
+
+		/* after msgbody, append extradata */
+		this_chunk = min(extradata_len - extradata_offset,
+				 MAX_PRINT_CHUNK - this_header - this_offset);
+		memcpy(nt->buf + this_header + this_offset,
+		       extradata + extradata_offset, this_chunk);
+		extradata_offset += this_chunk;
+		this_offset += this_chunk;
+
+		/* if all is good, send the packet out */
+		offset += this_offset;
+		if (WARN_ON_ONCE(offset > body_len))
+			return;
 
 		send_udp(nt, nt->buf, this_header + this_offset);
-		offset += this_offset;
 	}
 }
 

-- 
2.47.3


