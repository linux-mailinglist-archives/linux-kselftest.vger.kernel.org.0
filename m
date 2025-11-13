Return-Path: <linux-kselftest+bounces-45567-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F096EC58FAF
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 18:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 009374A3E81
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 16:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85272358D39;
	Thu, 13 Nov 2025 16:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JRiCSTLs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701C0328620
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Nov 2025 16:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763052152; cv=none; b=CjzV/siqT2CgLiy1bStLqFfBJaBC+UhjrN19uXVngSL2bkNMjMAwG2KVCoH2l5og7j+gulRf2oeWAootO8opoyyrhmXbzR5+wBwSkMjzV3W9f2g32WkfpFpXm8aNpr/sHQ18A/DlWVHpDOG+hRIi1cWFlCjqsTUsIpIdbakP1ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763052152; c=relaxed/simple;
	bh=4o/RxC43YnVQqRXczuDbSl9ni1pMUIIJIyrl4BDWu78=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mYnZ4Wpq4hBg+rO7pTjrMXRj6xUI9EvsQ+iPL6QBf9HwztPfkrGTvFrhCKnK63WW+84Z12X/R8fYl/gL9smiqtSNFYljpayCrj2QQzdnOxBE6yWJ0mhSZx6hPP6LVrXDTV/26IS4uP5/9jjfVjDs3dpPDnKVLoBfys2lejMYoaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JRiCSTLs; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-429c5e0f94eso91135f8f.3
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Nov 2025 08:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763052149; x=1763656949; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aMzRJ5pI2+TptVcafty876sJe4B1nGFvJf6ldhJSevs=;
        b=JRiCSTLsLq28r+pB2vnZiToDICfanVm+vpzw2y9VtDTkw0a1x2ouIiF1U3YPwLl8bc
         RcttOI5hl5JJwYKhs9KPrRb2nLYzULRgwnSm0w7SwD7JXwiJSsIolEVhuHZVdJliqRgG
         2sxYsxejpCA8gvrp1X3rDgwLKxrCeaz6xxH7yIUXaJU53yYNX3QoUmrV6f9QNITGqRXb
         PZIg8r+T4DckyiV0wtKauMdEhxwo3QscSS0WzYfSJl6TCwtPek6+cw+kCwB/z0h9sCr9
         7hovGPRVty4ic9mnQJjP3v/0o0FY7mcAL4KEsSz/xFUDzFVcDaFvm3qYdLrYpESdfcNP
         NNdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763052149; x=1763656949;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aMzRJ5pI2+TptVcafty876sJe4B1nGFvJf6ldhJSevs=;
        b=dUaNjoJmyMbZsW3IK9aaakYzJlWd9RmJWT8Pw9SUIdeoBV9WB4q0eO3HbYWTOfq97V
         H6ATmSvaR5mSDR+qCf6ZBkrOz47tsvlSPvHLQU6U6Fa1oI1wSMfLTGkZsVqIBBpZKg5q
         Mz+IO8ZfLHMwK7bBCmKTOW7I9TIGZid/gk436y6c3FEUTLI7YMY47whOP8A97xBw4qNZ
         EleRvx8alAo/OAgUECN0gE0uJawWdkJ7CqVWKso51TL1Xyz4X5fVdIBCQM1pGRX2QTlR
         P5g0So9HLi795cwzrDjd78kWfaon9Cv6jdF8+vjQIVLD0q2e6GcTrSFLKnH1IS8hhQB1
         F1lg==
X-Forwarded-Encrypted: i=1; AJvYcCXiR/FrNCt4iNPS9XqoJMh6C8271kqFwwKVWWqPaFoJs6J/J8r3BLQa/ZECEiOAgf1heVD+tCg0za6nt9xN22A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSr18RnlWSTMGlrTbHugYElOLQzYO3jEdoDl9istv7SO0t8K+J
	YGGH0EKbj3tyY7zOz1/nbD/t3JtrmBUlLn/Zqu0u286I19GI1d+eUqBz
X-Gm-Gg: ASbGncvQ4ail0It7X0NFgeezNupuCVMP1vyiFcQLcNSAq+6BBi5Xr5PJZCO1x6+Tggj
	pgoMDG9W45df6yGjh+H99WuJzoEm6Ak/s5cefKyOVzYdUDKRELzgMKmyUZi/FiduNHQE4c+WS92
	thThzR5Q2MVViGk+wOmWGk07KwIFRj98T7RFFrQsvT96XDzYIMVl8Kjp0TIPaw2QZ6rQn9HDr7h
	JrOFTzhGgr9z4m5f4Iu99PwlRSFh/xg3gy+Xzw+Yge856rAywyAbelJYnjyINqwARxogjEN/diO
	kajwXmZonl8cF4ZuNSmR4x7rlwnAlzlwi/LxHFUlBs/1hwu2IOsiAAkupH3tcsWEZentQ8mEqNB
	11PkOo1b/wftdJJcdeCgxkrgdGaHmn6jWelZql+cpHo5Vd5VxP4YHWOkAZWh38ZiVwFQkau/oQK
	bPdKdjGrR98nLY/gQ=
X-Google-Smtp-Source: AGHT+IGRCKn1s1l7XPuZ3WmfDrwdmb84hd7wM1N88NvGU0e/XOAv+o6GyT+T3hJdUvhK0yT5AjMEAg==
X-Received: by 2002:a05:600c:1f8e:b0:46e:36f9:c57e with SMTP id 5b1f17b1804b1-4778fea51f1mr825465e9.5.1763052148336;
        Thu, 13 Nov 2025 08:42:28 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:53::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e7ae88sm4824499f8f.6.2025.11.13.08.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 08:42:27 -0800 (PST)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Thu, 13 Nov 2025 08:42:18 -0800
Subject: [PATCH net-next v2 1/4] netconsole: Simplify
 send_fragmented_body()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-netconsole_dynamic_extradata-v2-1-18cf7fed1026@meta.com>
References: <20251113-netconsole_dynamic_extradata-v2-0-18cf7fed1026@meta.com>
In-Reply-To: <20251113-netconsole_dynamic_extradata-v2-0-18cf7fed1026@meta.com>
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
 drivers/net/netconsole.c | 111 ++++++++++++++++++++---------------------------
 1 file changed, 46 insertions(+), 65 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index bb6e03a92956..5fe5896d6ff5 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1560,89 +1560,70 @@ static void append_release(char *buf)
 }
 
 static void send_fragmented_body(struct netconsole_target *nt,
-				 const char *msgbody, int header_len,
+				 const char *msgbody_ptr, int header_len,
 				 int msgbody_len, int extradata_len)
 {
-	int sent_extradata, preceding_bytes;
-	const char *extradata = NULL;
-	int body_len, offset = 0;
+	const char *extradata_ptr = NULL;
+	int data_len, data_sent = 0;
+	int extradata_offset = 0;
+	int msgbody_offset = 0;
 
 #ifdef CONFIG_NETCONSOLE_DYNAMIC
-	extradata = nt->extradata_complete;
+	extradata_ptr = nt->extradata_complete;
 #endif
+	if (WARN_ON_ONCE(!extradata_ptr && extradata_len != 0))
+		return;
 
-	/* body_len represents the number of bytes that will be sent. This is
+	/* data_len represents the number of bytes that will be sent. This is
 	 * bigger than MAX_PRINT_CHUNK, thus, it will be split in multiple
 	 * packets
 	 */
-	body_len = msgbody_len + extradata_len;
+	data_len = msgbody_len + extradata_len;
 
 	/* In each iteration of the while loop below, we send a packet
-	 * containing the header and a portion of the body. The body is
+	 * containing the header and a portion of the data. The data is
 	 * composed of two parts: msgbody and extradata. We keep track of how
-	 * many bytes have been sent so far using the offset variable, which
-	 * ranges from 0 to the total length of the body.
+	 * many bytes have been sent so far using the data_sent variable, which
+	 * ranges from 0 to the total bytes to be sent.
 	 */
-	while (offset < body_len) {
-		int this_header = header_len;
-		bool msgbody_written = false;
-		int this_offset = 0;
+	while (data_sent < data_len) {
+		int extradata_left = extradata_len - extradata_offset;
+		int msgbody_left = msgbody_len - msgbody_offset;
+		int buf_offset = 0;
 		int this_chunk = 0;
 
-		this_header += scnprintf(nt->buf + this_header,
-					 MAX_PRINT_CHUNK - this_header,
-					 ",ncfrag=%d/%d;", offset,
-					 body_len);
-
-		/* Not all msgbody data has been written yet */
-		if (offset < msgbody_len) {
-			this_chunk = min(msgbody_len - offset,
-					 MAX_PRINT_CHUNK - this_header);
-			if (WARN_ON_ONCE(this_chunk <= 0))
-				return;
-			memcpy(nt->buf + this_header, msgbody + offset,
-			       this_chunk);
-			this_offset += this_chunk;
+		/* header is already populated in nt->buf, just append to it */
+		buf_offset = header_len;
+
+		buf_offset += scnprintf(nt->buf + buf_offset,
+					 MAX_PRINT_CHUNK - buf_offset,
+					 ",ncfrag=%d/%d;", data_sent,
+					 data_len);
+
+		/* append msgbody first */
+		this_chunk = min(msgbody_left, MAX_PRINT_CHUNK - buf_offset);
+		memcpy(nt->buf + buf_offset, msgbody_ptr + msgbody_offset,
+		       this_chunk);
+		msgbody_offset += this_chunk;
+		buf_offset += this_chunk;
+		data_sent += this_chunk;
+
+		/* after msgbody, append extradata */
+		if (extradata_ptr && extradata_left) {
+			this_chunk = min(extradata_left,
+					 MAX_PRINT_CHUNK - buf_offset);
+			memcpy(nt->buf + buf_offset,
+			       extradata_ptr + extradata_offset, this_chunk);
+			extradata_offset += this_chunk;
+			buf_offset += this_chunk;
+			data_sent += this_chunk;
 		}
 
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
+		/* if all is good, send the packet out */
+		if (WARN_ON_ONCE(data_sent > data_len))
+			return;
 
-		send_udp(nt, nt->buf, this_header + this_offset);
-		offset += this_offset;
+		send_udp(nt, nt->buf, buf_offset);
 	}
 }
 

-- 
2.47.3


