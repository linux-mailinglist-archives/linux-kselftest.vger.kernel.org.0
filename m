Return-Path: <linux-kselftest+bounces-43835-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B34BFECC6
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 03:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 193ED4EC0DE
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 01:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C1227FD48;
	Thu, 23 Oct 2025 01:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ISHve6E3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DBC2356D9
	for <linux-kselftest@vger.kernel.org>; Thu, 23 Oct 2025 01:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761181239; cv=none; b=p/75e9Fo9Cvqnv/5P+AweDPNTKYSVBbzis1IP6fr/f2WtpVVUHUtxZX6KCsVY7+ySOx3pTEXIRVV7OX0kGustv7ODtBxb1bcgaEgjOFKLngr4d3z6sxYc2UjDfpx2n3+TAdi8K9rf8Ilg8A8uma+Iu1YzT//MNg1hWjhykqq56I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761181239; c=relaxed/simple;
	bh=94uzV3VFEsNc5hciZIog7zBBbpwZzL3cEkwJ4Knqo18=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TopbspA7LztVQnY4AC+TUZlQXhq8w2T4uaqnma0IQhUypdQ6hfPz2fTdgg5bB3IbbOz87I0GhRbU5w7rwosKkXoGWlTYgjCNE+34GdquGeVbhE7FJDUJV21sz5WAtrBXEBQ1/sUJlotcLJGKhV3XdLa3nSDHtJu0fZGGMMy3InA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ISHve6E3; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-33d28dbced5so317971a91.2
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Oct 2025 18:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761181236; x=1761786036; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9KyrEoOAeZKPRfbyTnz5cosCWFxdbO0nbS1ytMd/2Og=;
        b=ISHve6E32hhuWJDWyvQvUFboTItF6+IRHd0M1Zi8dO/ngsEfaOqXuN+pIMCJrztSfU
         O+Hmou4a8pmogV8zTi1m5eHhXdWgi+FujR1jeA8iYSHz9+JkejtR4hok5/t4kBgfYXvK
         lAeoot42z63rJCbX1xSjdUkuA5ENWuH7CnZxWaO4+d0coZzbpiHcsMavTpFeKD9ueWqk
         fkz58+mhhWUdhyKZtd8CdqVIC0uVUg8QejlVkbMRTGSZFTPFh51p1OnUzTOcGdpm53Pf
         DMSRPDDX1kg/LnMqpVd4koiTkhUD1vo4OLOJe5vbnMyuqWIRFgN68dYQ4qwUSwx+aeG6
         B4XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761181236; x=1761786036;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9KyrEoOAeZKPRfbyTnz5cosCWFxdbO0nbS1ytMd/2Og=;
        b=dNrp1ItN1VbcgMLsYcyi0sfGI5zuIc24eA3fbwYvBNedFJYfRdAVlFTyjSb4sezE77
         iaQiDJH771nJZFiA2J/AkoypEpVAxtf8yRRAJ5BDhyE1xBsFnsGbqw+sjt7FA6LlxtKU
         5+qorb1WDx4O8RPVfI7nE/dF7/3Ew68owmXUIjc4TyaHLdpgkVkwHy+JDrGuXAg8nSgt
         spxChHf6MzEnRTsyQ+t3lEAsNH8fR3BjO1jbnAJ+JwGouk1Lp6Tv+8IflQP/rkSYJYOg
         YSgQP0I/xI0toe7mrH+oyipUCRYiJjiOUPbzrKxTUMpQjCOJr1koXGKsWIY3iVwxh5lz
         GADQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGcCIE9jQZC/akYhHlBXgbSgS1HgTzpnqwW+vSfcQVPbXiqfJai5sYv+xWvKyeuY8MtDpe/hYoRdQYS15rOsA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk/ynpvdqU8uxvb8OVRR67YSE0WzdRINqAxJ3MXPEej0R52HfH
	Qerq7Tk0Xc7ohbtGxsOUE8SUp1O9xlLCM2iMYCO7acmQRMwYrU8m7ZoLswTuLKmN
X-Gm-Gg: ASbGncut8M8qd3zEDkZVVkMUNOdjNVBvl7yUvpZZTYXK5dEmaEQ6O2vgRmUzLMcfHZK
	83XlTIBMaYAOuYrB3dtF4rcpr1QqQayR66C5xof5Ws/8Yh3SK3tqjN2fM99tetbkt54G0jigvQj
	BqV/C9uC5B30mMmYPRIcNR2tTeLnnFOjIK5njZqe1nucVOA2eRWKe2WlpOGMgBbO5rGtkdBSksd
	Bajq5396NlR/X1IeS6Sc+2P4fFXFJKZnQdKWn/7SEW1tvfn7lPvOFOMijoWhbdP9lTO24NT4EXA
	9XY7UaoTW2g+0y7q5EqyqSGGacxlnfmmtk9GXzUZ/RM9uaiGBpenOkZpAKoVNYkefrnZZroQou0
	6Dt1XQiRO+jgiwhIz3YFGh3pZT0bMUEbV313ExQu2vaeAHoXATNDBduPo8DLWNJWcGRi2ymcuIt
	5iO7Y3Cl40quS4c+7xhQ==
X-Google-Smtp-Source: AGHT+IEOXbL7VuQGK4ycx5x+XFWwQbZrBd+2XbxwOLCxBAkNJU5f38Hm416YN0mJLPBe2ibivOPQGg==
X-Received: by 2002:a17:90b:5343:b0:32b:65e6:ec48 with SMTP id 98e67ed59e1d1-33bcf84e1edmr30854960a91.8.1761181235816;
        Wed, 22 Oct 2025 18:00:35 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6cf4bb9027sm360734a12.6.2025.10.22.18.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 18:00:35 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 22 Oct 2025 18:00:15 -0700
Subject: [PATCH net-next 11/12] selftests/vsock: add 1.37 to tested
 virtme-ng versions
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-vsock-selftests-fixes-and-improvements-v1-11-edeb179d6463@meta.com>
References: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
In-Reply-To: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Testing with 1.37 shows all tests passing but emits the warning:

warning: vng version 'virtme-ng 1.37' has not been tested and may not function properly.
	The following versions have been tested: 1.33 1.36

This patch adds 1.37 to the virtme-ng versions to get rid of the above
warning.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index aa7199c94780..038bb5e2b5e2 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -152,7 +152,7 @@ check_vng() {
 	local version
 	local ok
 
-	tested_versions=("1.33" "1.36")
+	tested_versions=("1.33" "1.36" "1.37")
 	version="$(vng --version)"
 
 	ok=0

-- 
2.47.3


