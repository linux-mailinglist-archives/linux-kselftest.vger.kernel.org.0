Return-Path: <linux-kselftest+bounces-27931-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0BDA49F8C
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 17:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C5F43BA1FE
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 16:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92818281361;
	Fri, 28 Feb 2025 16:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bkv5Z4BB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6ED280A5E
	for <linux-kselftest@vger.kernel.org>; Fri, 28 Feb 2025 16:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740761713; cv=none; b=GU+AtWun0QSIfQvK0aKNZPENXNcEttobcamdlSKwjp7EuTyCB4SVyrZyd7dQd9cdVA23/j/JEt0JREMz8w/URq5fP9yFl7UEXTc8ZGCND8Di32Sc0RG/qHLPysoGHvJq0nGt3br8qPOX3caCBB0ftmePWP7GLNcQW74MkMt/abM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740761713; c=relaxed/simple;
	bh=bqfaJLRcZyL7lK8SQBkzsqIdYVbbY09r1mSEFK/Nr80=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iowWk3+tHXOaqyIcpPw2fpUyhDTJKxCaqWhtU9NCf3Jxlnx0LYnOpb/gZmNUIh4cjmypCAIlx71HXtL1brNR4qNMRGzSTI4QCqe2Tl0nNe+MTS0C7bntsz4DoKL9JYf62bDCAfaSEMnLBt2GvhR8t0E+EhmoWEvGj4HSyMPKtlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bkv5Z4BB; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43ba50406fcso11219785e9.3
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Feb 2025 08:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740761710; x=1741366510; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y083FvFOZYoCnUIFRlzf3KdIVhM7Xy3dpgrJnz1PRMA=;
        b=Bkv5Z4BBl2uu1KIhclleMqZL059tOjjZ3/eT/1ZpnwYLrUrXUB4iCOiC1A3nr0kRH/
         PE8mFEI/njsw7rzdtsU7S364JKgcB4FJxYoHnu255aCTYM4aEJhjBTdbauvRy+H2Fz5m
         k/4f3H4J2bx+cxg96ZIi7A+X7abqQOgu65PTvxAO03xtcBUxtAf27n4dRoJTGmoDMmpH
         uhBa9aXu6e6XWkB3BHlV9+/dM4N+yMvl5I/oplJ/iGzMumKGOjcwi85lnzizSB4+QAly
         lXVh0ttBMDzULLCnsZgHx/SQ3YfpX/unrFisUNDIq539/8PxiUhTFJQADw/0afBTwmWI
         pQ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740761710; x=1741366510;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y083FvFOZYoCnUIFRlzf3KdIVhM7Xy3dpgrJnz1PRMA=;
        b=QgsYGa/7INSpyie6E4Nt1WaFh0MgeAkoHIU8BGRX167SQRtiFX1zivqE/TUtjcNXCJ
         k/kzqTaVrk29HXVHTTGJHCKESBMSi1SNYsQVtSCz66X9y0ucKgmImpPG4GU3GjbPjiKm
         P7ElODHeLSL+mmgsWBailccw5fODwhLGblveBKZYWbwhyrqRCuplD4Kjnq2K8UEICP+3
         hYV/mQAHHZf/ZjKOTBwUS7PiYQVtntM3ACugrc/04EtBE4BCREnHuuExYVVGrGAyoaBE
         429TyVStV/R/Mo0+bDuiremg4onudqENtf8YU8yGBtQd/Thdh3ey2Wu3ercS4YKSSUoh
         rxig==
X-Forwarded-Encrypted: i=1; AJvYcCXC3XC195vcsTHaJX1PAo+ZGjhA2xdp+TxJhWl+Q3fPHuPayyXBF3etu4UwBUrl1xRFKgLhgQqFQgMbEPGk/F4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQvc/00+saYsIhnbkMRX/NUlONst/BDKG4Yp/tzUmRUqeH6TdJ
	HeQIGl63TO2jxd+vQ3rI+3g60k26v6mOYr0Zw5TrvSdTCmBuiBc+jMTyFw1T/MsvGT/1WCBSEHg
	8XFSNHpcPSA==
X-Google-Smtp-Source: AGHT+IECfVJfBnP7dSUDnPjhj6/A2ktPEKiVIkWG9TWFGAz0YIN0dg2dmHqMiFJ6AA8ejEBgQ+HIjLpWvE2+0A==
X-Received: from wmbfm10.prod.google.com ([2002:a05:600c:c0a:b0:439:81e4:9ca6])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:154e:b0:439:6a7b:7697 with SMTP id 5b1f17b1804b1-43ba670fb9bmr36911975e9.14.1740761710535;
 Fri, 28 Feb 2025 08:55:10 -0800 (PST)
Date: Fri, 28 Feb 2025 16:54:55 +0000
In-Reply-To: <20250228-mm-selftests-v3-0-958e3b6f0203@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250228-mm-selftests-v3-0-958e3b6f0203@google.com>
X-Mailer: b4 0.15-dev
Message-ID: <20250228-mm-selftests-v3-7-958e3b6f0203@google.com>
Subject: [PATCH v3 07/10] selftests/mm: Skip map_populate on weird filesystems
From: Brendan Jackman <jackmanb@google.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

It seems that 9pfs does not allow truncating unlinked files, Mark Brown
has noted that NFS may also behave this way.

It doesn't seem quite right to call this a "bug" but it's probably a
special enough case that it makes sense for the test to just SKIP if it
happens.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 tools/testing/selftests/mm/map_populate.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/mm/map_populate.c b/tools/testing/selftests/mm/map_populate.c
index 5c8a53869b1bd287b09a250edf628a66c25c2439..433e54fb634f793f2eb4c53ba6b791045c9f4986 100644
--- a/tools/testing/selftests/mm/map_populate.c
+++ b/tools/testing/selftests/mm/map_populate.c
@@ -87,6 +87,13 @@ int main(int argc, char **argv)
 	BUG_ON(!ftmp, "tmpfile()");
 
 	ret = ftruncate(fileno(ftmp), MMAP_SZ);
+	if (ret < 0 && errno == ENOENT) {
+		/*
+		 * This probably means tmpfile() made a file on a filesystem
+		 * that doesn't handle temporary files the way we want.
+		 */
+		ksft_exit_skip("ftruncate(fileno(tmpfile())) gave ENOENT, weird filesystem?\n");
+	}
 	BUG_ON(ret, "ftruncate()");
 
 	smap = mmap(0, MMAP_SZ, PROT_READ | PROT_WRITE,

-- 
2.48.1.711.g2feabab25a-goog


