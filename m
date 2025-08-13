Return-Path: <linux-kselftest+bounces-38832-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE460B243A5
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 10:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BE843B1C83
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 08:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531D62E1C56;
	Wed, 13 Aug 2025 08:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dX9KlHD2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A37283FE4;
	Wed, 13 Aug 2025 08:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755072159; cv=none; b=TApnEmdoej2MTa6dYpX06F+TRe1k2wTpO66jREJ3V/GsHOQ948opWBybrSjoV81IT+m//QbohL5sbPREtNp9O6ck+Bu7Ovs1h0bo0zFoaXWXUkKTtnG4r9SBtJ5Q/vbtUxR3Ml8hjirzSRv92e34uEZNEYImgNtyCzTfwNtwtA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755072159; c=relaxed/simple;
	bh=nQvMo01i5zzawzSDp3kh0vDqtAYbjljpoQbinuOFPq0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n5iqwfa8b5znLE/jwUufIyEVn4SxwsiQRH5gIpIZkwxBS28sOgQMAp9LKacr8YR5tQgojJ4mwghAIYVRjZPp1rd0uXm1HIZhyVUw2aokiIW+GpHaV+tT6+c5maqk+JJEs5Teb5uFA1q/x0HMDcfH/neAGa4L0u4R0u0AAcBsThE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dX9KlHD2; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3b7825e2775so5705600f8f.2;
        Wed, 13 Aug 2025 01:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755072156; x=1755676956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XVe0idgYx1J+jUFo1Pbaqi+aQhg27OfKm5O0YenTYzE=;
        b=dX9KlHD27fcm5mVtNCU5M4dTxgJ6o7wNfuazAw7SUUPAZu30PlOzFipywPTVfpMjFy
         PRr5wWA97mzGjphskk6KsXQ9uhktenzS7wmRHkMp7E9m91XQj9PZpooYp0Rw4hLada4Q
         cdROrpL9+DstpS3cLGK9+LhDZK7nR5vX6ftBAiezQLjsGXO7nbefoNUnTkBsVhsqjXe2
         EVLwjgq17I60xiLg9zYA29TwxabocDie3K3tb43zJ6eS3dui5iqaSvDPjz7BXpbvZdfO
         EGRBIjhfTHtBe93ha2So4OgZC9B5GWPYiDgsVtWLWWqGXcsa5ZgSvP32XRBoLJ7bHYU0
         7JsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755072156; x=1755676956;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XVe0idgYx1J+jUFo1Pbaqi+aQhg27OfKm5O0YenTYzE=;
        b=Yf937yM8aJkAaespV6/mHwo7czcgfOJqwNQAFUz9Lw/4RF+rTZumOEfeOM7aARHDWB
         LuDeTT1Pe0xOXtHInbBg5TjfT8DUqRgwfI8ifRD+NY/m3nJN+E6XgbKeiEe49TXtb1ao
         z2xvbDcOii4R5FgiG/b7AJlLQQOWb5rwFz6IuOpEjAMnYiVpwbih9E12owmpRNoLFP5U
         7FzAJKXm/rNEIA98ZBgstEzZJGlMKKXkkCXc4tZ9cFWRkjINkmfV49lOxJGLP5ZYBQfb
         j3KuEOmT/5e4FhyD3Y5eMyckRgd91FXsjo5zd5zylORVZWaBSlUzIKOjM65lVWVduyiV
         ASGQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1aAp9S8W5WhyQVgMIgqi7lavkA/5GcfkE9JPvAhtKTaejASEiOzF5jdmaGV7kF+bc6nEnKyM7nWVnd8Q=@vger.kernel.org, AJvYcCXWOytSdEbu/T2uPZQjFLoKvkBoKQwNO82FMZaopWPF20KrCStmaL8hjd15XKLFBStw09Ly/KzbcDllla0/H5zh@vger.kernel.org
X-Gm-Message-State: AOJu0YwX00nnq3CUnN6wmL6dPKafJSl2B3EwPFNQtuH7SnhoBPS1n1wI
	68ypXNItSFzVNmck3hvfdNDV3CnKZJwBXc8V3uqVYv0tQzfXK+S0GP/2
X-Gm-Gg: ASbGnctUPm39+XRyB5P879Glcy5da8cGiITGfmyBW9xwePm2lJAuy2eAxlnrKcLvkGs
	XccG4XEpjtVWc/iOja3b5uLfwCwH1ZysecXaqniKZRkHLwhw14AD6lHylYnH2fSMpQzazT96v8A
	pRvrt5wnQEtUMQiJMh0i9MLcOc42WPRB2vjdu1lYFkjuKn04Qk4n0haW2HljStMrPadue7EpN5+
	BU4wAx7Zf9fyc+DBfvRlKWEzvcQE15bzB2l0aF3PnPZ8vxeNdfauZbEYCVv52nxSfSwUmMqYaKY
	JYm5EnpDNlfaEE8thfXOe1+SCIZpOfAoM5cei5IyF8DFmSxtPn8nWHHjlQvuxaTILmPzF69xZ01
	iIclINOskz27Q07fNMwih
X-Google-Smtp-Source: AGHT+IF2JGABNVx7BZux6MpyAVD1R1nKdKMygCmpURXyXIjOojtcxVvm42vK3OiP0B8MvRjzDo8c+g==
X-Received: by 2002:a05:6000:240c:b0:3b7:8af8:b91d with SMTP id ffacd0b85a97d-3b917eae69emr1631360f8f.35.1755072155716;
        Wed, 13 Aug 2025 01:02:35 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45a16de760fsm18991555e9.17.2025.08.13.01.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 01:02:35 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] selftests/mm: Fix spelling mistake "mrmeap" -> "mremap"
Date: Wed, 13 Aug 2025 09:01:56 +0100
Message-ID: <20250813080156.1977375-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There are spelling mistakes in perror message. Fix these.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/testing/selftests/mm/mremap_test.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/mm/mremap_test.c b/tools/testing/selftests/mm/mremap_test.c
index 5bd52a951cbd..e289bb1112db 100644
--- a/tools/testing/selftests/mm/mremap_test.c
+++ b/tools/testing/selftests/mm/mremap_test.c
@@ -846,7 +846,7 @@ static void mremap_move_multi_invalid_vmas(FILE *maps_fp,
 	}
 	if (err != EFAULT) {
 		errno = err;
-		perror("mrmeap() unexpected error");
+		perror("mremap() unexpected error");
 		success = false;
 		goto out_unmap;
 	}
@@ -899,7 +899,7 @@ static void mremap_move_multi_invalid_vmas(FILE *maps_fp,
 	}
 	if (err != EFAULT) {
 		errno = err;
-		perror("mrmeap() unexpected error");
+		perror("remapp() unexpected error");
 		success = false;
 		goto out_unmap;
 	}
@@ -948,7 +948,7 @@ static void mremap_move_multi_invalid_vmas(FILE *maps_fp,
 	}
 	if (err != EFAULT) {
 		errno = err;
-		perror("mrmeap() unexpected error");
+		perror("remapp() unexpected error");
 		success = false;
 		goto out_unmap;
 	}
-- 
2.50.1


