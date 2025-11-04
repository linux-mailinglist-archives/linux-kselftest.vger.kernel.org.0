Return-Path: <linux-kselftest+bounces-44761-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C10EC3341F
	for <lists+linux-kselftest@lfdr.de>; Tue, 04 Nov 2025 23:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9F6A84EEE46
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Nov 2025 22:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38209346E48;
	Tue,  4 Nov 2025 22:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ghumm7Pj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09036328603
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Nov 2025 22:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762295955; cv=none; b=bzFFzazTydUBPXqfxVyyfw68Jm9sq/Toc7gnmPbE3GIloOgROZx3gqhzmVJp3L3mzBrAUkzJmGr6bjehv6zwMN7HF4jQj8AJWMs74FfMeYd15oxHzB3VHBm8ov7+DRYWsoWwMfi2dUkzlNXL2TuZj7lvSOXP/AjaxXZCeCmvTt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762295955; c=relaxed/simple;
	bh=MP2KoZXX+79Mi4EOxuj0JaxBOJBdoc+sCYGsGHNCwUo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YGcAE4OPsWfVta026V7qD2LK1h2uMXjFoZ2dDPyMZ2xlt09s63J6X07Azo7fPwJWwObBCwTtXbTDlQtwqNWXIYyNjTyrumMujoq3rvrsRLFF/kv5XuMi1Yul2ms1K9SwnfRaOrTLuwzRVAK7RGodt8+XQFz1t03CiPjX22SU91c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ghumm7Pj; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b679450ecb6so4591116a12.2
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Nov 2025 14:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762295951; x=1762900751; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j2TtF77uA9Y6v8jmRi2a/W5oTLXZ//NRPnuqn89vDsU=;
        b=Ghumm7PjRqXPAsnxOBc2oQIiGww/tpfuDykkyRIgzJ+5rMGZX395wg4T+TEasn/6nO
         KZ1UHkU9oAci8OcLg+7qGS1hJgnmzFCSi3N4W/1Ji4P2E8SAG3KwjhgeLtGa7sMEAZiW
         fJv5x7DXAnvgAQXqtqTNfrlKjew+n6k12B7ufE4Yn1zgQypFfF+2KoQXY32G3rlx1nWL
         BGkCGQAXbBKrj4dvrH9rcwvl/vUo1U+n6D8snWKNrxrzWAPD6gEIfXGWN+ek40ITjoew
         Vd7Ghxbm2uJE0V8pOuBLxJfM3XXRsQrV2oxJK9jUF6F5FBUzEhfIRwnEcw5DbKXZmudD
         UFrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762295951; x=1762900751;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j2TtF77uA9Y6v8jmRi2a/W5oTLXZ//NRPnuqn89vDsU=;
        b=YlynXoUm2NABzDaOd8d0ngE2iyCp/mph6mD/wuGE4ukhLG8cS9cWVUjuA1kjIHoK7c
         PilTzWSjJcePKW3iCYTDwPPNIv42Y+7Dv5oKSMmSQLpKXMXfq1jY3kfsrryK0/RLy8mN
         S/FzYHfgWjRRiKHuqHpcK/jjHSg5B04CBk/krAcDvjFTyFV4krJnKFVW+qaPUW46BrW9
         2DwQxtJutzHiMOq6rAZqa5Uz/hBoW0BoidABgURjyfMPP8rgWhXqnV1CkklXJAcjS9zU
         Tf4Y5pYPcnab83K1ODw9CAA63zFbIjTVqlXjUJ+sVygA0ccrs0pZJ3FWBQw04kdWMvhX
         eUyA==
X-Forwarded-Encrypted: i=1; AJvYcCXsFNyXwVRxYXicq3MV6G6wBtev/GBZCc41qDCOh7ma6iERetzqDqR8a+iwuPkerui0zvlR375VUsoNOLhyOJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcnRRtJQfbMq0k/N1pirdGrfsQMAMpvNJdPUCTDa34IHuJaP5I
	whAJgdJv7VzjV67F/tWTSkFEYSb6MVOCmIjJwa+j/KmG6iIEwgrsHSXu
X-Gm-Gg: ASbGncvJBJEaSxCLkBpVIe4Kofpkhv4k/v+jKUUbsEYV+2hxA9NS4jn6hmRShptMbxM
	uHTZ7/pD6yyQekF11BoZMtrmnqDR5htns27Wf3j2w5En0iBjUrDWvseVrxcDexCr1ts2CGI1sCG
	jEbDXTsQRIoOmAJg0Zopv209fPb0r/typ0IlZmYaxFzCAF5Gqpq+AMksiVhIluVe1J06jqxKnfS
	xye6LDoGz9NSOgXxTpMLlggHT9XObShKbsYatPCUnvTNsZ5Kcrdu5Pn4z7dyDFYt1cV04DnY63i
	kQd703aEwpCvnjDdMfH1+b6dQSUEpPZMV+eKJ7TawjUkZKs1DmXBLDS9IRI6kOnBBEyYg1AXTw6
	073y+5nwWIgkgQMMiJIggkJtiw+KcGc2yaAvR8vECZqEGUebfUDWHMlsmKQ5OkGZrBD0GG/O1
X-Google-Smtp-Source: AGHT+IHjLept3ve48AUPW/GiyFbQHZFSoms2OQFSZb1ZP3j5dSJ+0pBWFTSSrVMg5PH2kQRmlJsbhw==
X-Received: by 2002:a05:6a20:7483:b0:34e:63bd:81c1 with SMTP id adf61e73a8af0-34f839f5a57mr1249874637.3.1762295951213;
        Tue, 04 Nov 2025 14:39:11 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:8::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7acd324680asm4163732b3a.1.2025.11.04.14.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 14:39:10 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 04 Nov 2025 14:38:52 -0800
Subject: [PATCH net-next v2 02/12] selftests/vsock: make
 wait_for_listener() work even if pipefail is on
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-vsock-selftests-fixes-and-improvements-v2-2-ca2070fd1601@meta.com>
References: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
In-Reply-To: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Rewrite wait_for_listener()'s pattern matching to avoid tripping the
if-condition when pipefail is on.

awk doesn't gracefully handle SIGPIPE with a non-zero exit code, so grep
exiting upon finding a match causes false-positives when the pipefail
option is used (grep exists, SIGPIPE emits, and awk complains with a
non-zero exit code). Instead, move all of the pattern matching into awk
so that SIGPIPE cannot happen and the correct exit code is returned.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v2:
- use awk-only tcp port lookup
- remove fixes tag because this problem is only introduced when a later
  patch enables pipefail for other reasons (not yet in tree)
---
 tools/testing/selftests/vsock/vmtest.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 1715594cc783..da0408ca6895 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -251,9 +251,11 @@ wait_for_listener()
 
 	# for tcp protocol additionally check the socket state
 	[ "${protocol}" = "tcp" ] && pattern="${pattern}0A"
+
 	for i in $(seq "${max_intervals}"); do
-		if awk '{print $2" "$4}' /proc/net/"${protocol}"* | \
-		   grep -q "${pattern}"; then
+		if awk -v pattern="${pattern}" \
+			'BEGIN {rc=1} $2" "$4 ~ pattern {rc=0} END {exit rc}' \
+			/proc/net/"${protocol}"*; then
 			break
 		fi
 		sleep "${interval}"

-- 
2.47.3


