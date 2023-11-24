Return-Path: <linux-kselftest+bounces-590-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D0F7F7A2B
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 18:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3212F1C20A86
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 17:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C44364A1;
	Fri, 24 Nov 2023 17:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DqWgB3HR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE0410E7;
	Fri, 24 Nov 2023 09:16:50 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-41b7ec4cceeso10262791cf.1;
        Fri, 24 Nov 2023 09:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700846210; x=1701451010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xg82JrfzBfyMPKKSBUKzAJjlyzjnEcy1rIS6yPWPAIc=;
        b=DqWgB3HRFRa6CcJJ6PanGKae81xoKww8sqiVWcuh7RajQ6uFEzb9ToA4ExBaABQ2wv
         ANoQyX2a7+7cdFMNYPHI5rFwQnIg9Jbp7/cNCR1tyzsZc/K+TLJn+Oq63o7wCJP1t2dB
         WOvYD96CnBpEdtyBtJkifqgdIFRUc3fxf/CAq7AQXUSugM6xBDn+vIE12+YEC0c+fahF
         V37jf32i5FsJMQMCzIZIXVK3NkQF0Jjc1AoxGBg3TGjQo6VpvA0rdUDkq2HqgAJPDt9l
         o8onqGLgeV7IN7sR/R2epJv23w71g+1HHSa6MV/c+yL/dC4+Jj+t0+H+DdlsDRddoxAp
         6nBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700846210; x=1701451010;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xg82JrfzBfyMPKKSBUKzAJjlyzjnEcy1rIS6yPWPAIc=;
        b=tZ/3DxXe7VUty+7+dBu0vd9FpSEnMb+wh8f/IFAn426Yd6YwzemcJU8jzajnI8yunt
         hHp9CZ03IB5b9neKoxzMFSpgyAav9oYCEaIfP4P2jJ7bGOGPyDzSVefBN7HgtpPolPg1
         QyFmKegLyMxUe0K333rQDgnen51C4J6bOZsr2JxfuilBmxHXkmjNqDgKoCRaSf/YGY0A
         E6CakY8rfofLoZu0mYTB7MWUbHXl7d7BQd7HRt9Yl+9vHZRah5AUFsypk7cUqspECHEG
         Uvg2MhbeTbcmLPp5vIVI2E02pHxRuBx4IBR1CDUf7UKrLGTRQ9ELGesWqXvGbRJaNKPS
         ygdQ==
X-Gm-Message-State: AOJu0YzygThEOU27T7rpSvxBLQvPn3TlzlAkgfrrJ1gXCy8M5TU2OKLS
	AfTSsGEyJPjpxWL30YrrhZbN2Sd9lRY=
X-Google-Smtp-Source: AGHT+IEk0lodYaHM2GkoX6TloY5EenuGOW0yAp6K9Jyv3l6ywMv0A3UI3Wiq9C5VR4Ik93Q75lmP3Q==
X-Received: by 2002:a05:6214:419b:b0:67a:ef6:c3d4 with SMTP id ld27-20020a056214419b00b0067a0ef6c3d4mr5406800qvb.26.1700846209891;
        Fri, 24 Nov 2023 09:16:49 -0800 (PST)
Received: from willemb.c.googlers.com.com (240.157.150.34.bc.googleusercontent.com. [34.150.157.240])
        by smtp.gmail.com with ESMTPSA id mn23-20020a0562145ed700b0067a0a00b24csm1389278qvb.73.2023.11.24.09.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 09:16:49 -0800 (PST)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-kselftest@vger.kernel.org,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net 0/4] selftests/net: fix a few small compiler warnings
Date: Fri, 24 Nov 2023 12:15:18 -0500
Message-ID: <20231124171645.1011043-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

Observed a clang warning when backporting cmsg_sender.
Ran the same build against all the .c files under selftests/net.

This is clang-14 with -Wall
Which is what tools/testing/selftests/net/Makefile also enables.

Willem de Bruijn (4):
  selftests/net: ipsec: fix constant out of range
  selftests/net: fix a char signedness issue
  selftests/net: unix: fix unused variable compiler warning
  selftests/net: mptcp: fix uninitialized variable warnings

 tools/testing/selftests/net/af_unix/diag_uid.c    |  1 -
 tools/testing/selftests/net/cmsg_sender.c         |  2 +-
 tools/testing/selftests/net/ipsec.c               |  4 ++--
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 11 ++++-------
 tools/testing/selftests/net/mptcp/mptcp_inq.c     | 11 ++++-------
 5 files changed, 11 insertions(+), 18 deletions(-)

-- 
2.43.0.rc1.413.gea7ed67945-goog


