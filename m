Return-Path: <linux-kselftest+bounces-19193-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6A8993DCE
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 06:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8659D1F245ED
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 04:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39D5762D2;
	Tue,  8 Oct 2024 04:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CEZeQsWM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B1237171
	for <linux-kselftest@vger.kernel.org>; Tue,  8 Oct 2024 04:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728360588; cv=none; b=aiPrQvscmSratYKylHDbn6SIU2P5QLiL4PgGl8gOo8tJOFn47NxCxaxRI3Qn0Atw86b9ARfl9ABWMhBiSzAm0Im+F0bfQdfW74zlH5kcHLPdHbVCxBSAGxBUHTuSwzAp72ph947FXWnavNs89TkKLVkIXCtysDAL0paL43CubEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728360588; c=relaxed/simple;
	bh=CpYT2bjDDZ8HeA0Wb6hywG3ciBJ1GbJbSGD3iK0OK5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UiQ1kb0dGqhCOl5ZFqWNA3jmglrYNpWKeZvXlTzl0yFFhJu6iLAPoN1U9IT3kzd+6Xu23jLX3bJQ5NAlvtv3vu6rbUgHZbvtjLieALejmReoK2NWI8wDwnhouBv9imEvfdIo9AbnyLoUPiwLxdD+AeIgiJJZHULfRAd8MbAIjBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CEZeQsWM; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20b2093f1cbso4509475ad.0
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Oct 2024 21:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728360586; x=1728965386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p6ZGUL7jMwMvNfJbHmiytAX9Q9GIqYELEwcb1y0M4+A=;
        b=CEZeQsWMG6YYP2FjucGABSFYmtxCEL+fna8y31H4T5cTOpYokNgCZh4NnJeyKYzcx0
         /CEPjt9aaYu5cALiMhKRMZ9SJZDEKBOek1BXDFCXUfT6lZb/CPFPJTKcYLRFYaBhcmQ1
         xipBTXoUp3KuJpTXVZKEFiWABUk1MHHBOrwek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728360586; x=1728965386;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p6ZGUL7jMwMvNfJbHmiytAX9Q9GIqYELEwcb1y0M4+A=;
        b=YP996mBs0QqvsNWPr27rd6uVIjCVsA4WII2yyHpVWI32KEQc/6oGgIlivP2misfaa1
         SCkt7B/Pfqgj75Qxzyftk/Dc+1Nw6T7ENDm6z5siZxev7hiF67CT2Tg3FTwMezSSXRaU
         SjUji7BBAJVaM/NOD4HgapMTbSqPqzXv0pVvpy/LjgDKZWw1nj+F5P91//jA4dTvZSB7
         ZLCcN0HGxkzZGEaVHSgdC/r+Rq8oKvVGkXr02WkHRyT656kayqs/8cLz/Kx+sVCChIQG
         554e4FuCkWhtFZ/MDyouw40YR/xU28uPpb3mrRbUu/so4QEdsNy9ofsxStZuTIIzgTJP
         ojbg==
X-Forwarded-Encrypted: i=1; AJvYcCWPPvPkBfOv1RANVKNtiG2dBH1N3PqOvkELNI4HaA0PJezweYvFnlwAX1U+/PZ94Pkg6aN0FsqqmsAmNDgu4/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE2JheSYfGHm1w1eMxoghlF1e1aRh2+1GG/h4STDl8g2K9WELW
	Rkk+tkxiAW21I2in0kmEsZgJl++VC4m1tVK2ci8PsIZXhl7tohHKE+telnT43A==
X-Google-Smtp-Source: AGHT+IH3Tzn6KlmwwEjDW6lynG5u+Vt1tkuQKry5GB3eE3XfLVQF+SrNLkDuseDanp8wOy58Zy4SaA==
X-Received: by 2002:a17:902:ec8f:b0:20b:5699:178 with SMTP id d9443c01a7336-20bfe04bdd1mr89735445ad.5.1728360586544;
        Mon, 07 Oct 2024 21:09:46 -0700 (PDT)
Received: from localhost (56.4.82.34.bc.googleusercontent.com. [34.82.4.56])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-20c138d4fdasm47234075ad.118.2024.10.07.21.09.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 21:09:46 -0700 (PDT)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	keescook@chromium.org,
	corbet@lwn.net
Cc: jorgelo@chromium.org,
	groeck@chromium.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	jannh@google.com,
	sroettger@google.com,
	pedro.falcato@gmail.com,
	linux-hardening@vger.kernel.org,
	willy@infradead.org,
	gregkh@linuxfoundation.org,
	torvalds@linux-foundation.org,
	deraadt@openbsd.org,
	usama.anjum@collabora.com,
	surenb@google.com,
	merimus@google.com,
	rdunlap@infradead.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	enh@google.com,
	Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v3 0/1] update mseal.rst
Date: Tue,  8 Oct 2024 04:09:40 +0000
Message-ID: <20241008040942.1478931-1-jeffxu@chromium.org>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

Pedro Falcato's optimization [1] for checking sealed VMAs, which replaces
the can_modify_mm() function with an in-loop check, necessitates an update
to the mseal.rst documentation to reflect this change.

Furthermore, the document has received offline comments regarding the code
sample and suggestions for sentence clarification to enhance reader
comprehension.

[1] https://lore.kernel.org/linux-mm/20240817-mseal-depessimize-v3-0-d8d2e037df30@gmail.com/

History:
V3: update according to Randy Dunlap's comment

V2: update according to Randy Dunlap's comments.
https://lore.kernel.org/all/20241001002628.2239032-1-jeffxu@chromium.org/

V1: initial version
https://lore.kernel.org/all/20240927185211.729207-1-jeffxu@chromium.org/


Jeff Xu (1):
  mseal: update mseal.rst

 Documentation/userspace-api/mseal.rst | 307 +++++++++++++-------------
 1 file changed, 148 insertions(+), 159 deletions(-)

-- 
2.47.0.rc0.187.ge670bccf7e-goog


