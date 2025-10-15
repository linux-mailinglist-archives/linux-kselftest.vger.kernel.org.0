Return-Path: <linux-kselftest+bounces-43171-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0E0BDD797
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 10:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2D1DE4E99E9
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 08:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9CC33064B5;
	Wed, 15 Oct 2025 08:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z4SA0pay"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4A022A4DA
	for <linux-kselftest@vger.kernel.org>; Wed, 15 Oct 2025 08:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760517817; cv=none; b=PmmJuRIvkMzJY5HKQ5EXUMGGvi2rHuQcziSuVQkzYExOVmmyJs4RpsJ5kXB35d2/D+JqSCgDyAFdSr6lP0RMLNEaQmDclTBuTJws1SAouf+s6yIsi6WpkM1i4Ut4iSRCfXbkfnrC9yydvFAQmGuPx5IaH20y8PpQ3vtsxlvMrQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760517817; c=relaxed/simple;
	bh=lYSR5jLdMYtmxb5k1Xke197I3phnNIjnW5MizFZ0tWc=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=TeWTbFP3SfnmtHgesYySsk9mTz9kvg4mw1R18yGd6ZyoaKzOWLr4FGM8X5LaFK3XX5g57bk6gPoGC22DJrylAPtWLh+QTv4f41o47Vf5Kna4AA2POyfOuj9iMYeffvsMvEcofvm0oTI9DWnaeqzNTnk0mT3a2SOLxmGRdSCcBcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z4SA0pay; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-38627e78203so3232123fac.0
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Oct 2025 01:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760517815; x=1761122615; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:msip_labels:content-language
         :accept-language:message-id:date:thread-index:thread-topic:subject
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Cxf53tuYiU+Dv+DHgj1lSI5Z/XUbb+V/oDZLK5mtN/g=;
        b=Z4SA0payohni1ootUfeTHVzlUhR9ML05sXVVb4yaS7itBEA+yddgICzdCBRoe9cJQc
         j22Tomtm2FqoqfDKO7CgORKGeKdMNVjWukJIaHaGDFaxa9SM4l2PZyrwEeqC282FBBHO
         3FzQy8rZPR5CCuV+jc12w9+1zrReoGVX9ZI8O5t069jLsaSyo3zuESYKo61NNde8w2xn
         1TE1Cqu88EzoPWO7m3nA3kKyzvJncS4NtLX6Ca0opGjP9ZCS37KWZRkRouSUrS5r0SRH
         +xwbGvM4iMoBPQNgNfDqQ6WBqr7wNiOP41/gvNmTIhzIvsmCHfWSIk3U48EHJ2FDkh0a
         ftCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760517815; x=1761122615;
        h=mime-version:content-transfer-encoding:msip_labels:content-language
         :accept-language:message-id:date:thread-index:thread-topic:subject
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cxf53tuYiU+Dv+DHgj1lSI5Z/XUbb+V/oDZLK5mtN/g=;
        b=BsvPz7FSUqvJZQV+BJaEEfam/W5iYG3RQYfXq15TaYZxFoAsmHHKVz99X8/ZX8hfZw
         3pzVOqjz0FugWt5eGw4AxkRtCus1qA4XNhfd8vS9GzrB5TN4ps651FI8rc8FSMwArH6u
         XQJ1hrVSYY2tjAXHqtuj6OiYXBJgCVpsxFQGj7yl3wwt8cClaQLdNSQhOYUMgD0O8o05
         o+s98+X8BoYr/D2GM2yCnl+S6181YYWhDYcGDJ7JBBnZzi7h3eZFag0tsqs+2340XDBL
         xGDAp8n3RSARtQPP5YYXwfdCreJxGsn3C/5wUvXy+FlfasO8KsOKeKGus8zY/ixyyp+A
         cjOQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6QPS+mniuDoSL9CdWeSYJ+OLg2/jmiEw5CkZF6DzbaZSBVG06aVaoDJhB80XhLvdw7TbpPUZ7XzkpduIjhh4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOPBmDIB6WcWpCcNojvZyD9TTpD7gafv3BI/xq9OgiWX+zpdZp
	Ku/ojy/qWkVj5ffdXDwLWLwSAGq4oXdO7vzJV5PTpCzNCnXl5Z0fZewo
X-Gm-Gg: ASbGncvCj1w3xB+CMkRtB7aHkohAiUHvYavd4XNmBlLlmK/5AXhQquawlZ62oToD2ih
	xTqGaWysQlTueh32zbJZb15QVvpzELphuOFVP9E0E9UsiaeVIuU4VVIW0uAwgUGegYfcjhzv6ZF
	3vPSMzp09t6i4PBQEoHSmP0kA1TphTlZ1a3i7sI9i+Cn8ywPGWMsJOQ3OrdCr7roVjf5GAwTArP
	K0nsF2Snr4y0T7tVUvXnmbPVZ2D0hHMDCLDqmYmRqkwkXZkhcKWt4IYUiBe84wlWMRdmdXqVEl2
	Nx2zdL6ushW/VRgWnZweVCTsjW4T0b7xn6Nn6i50m0CSnCwINfIbtDtAyLBapwBHXPykC2DYiVb
	0X0BQIh7kMLE2evET6tIkvOsax4WFkShUpIWUAdl+dh0EIDR3/Rf+WlY9T3wuBxP/0iG6dq/6mt
	nqJiveAPA3J8iPqvUb+NPrpzfpeRVpkLO+iU5e
X-Google-Smtp-Source: AGHT+IEW6YfwO2Hw5oVjmZcWhTT2ZwRVCeYlsQeMytKJhVKsXPe7o8q2gMr9wQUGjacZjGQXxV3gTg==
X-Received: by 2002:a05:6870:d8d4:b0:315:663f:4056 with SMTP id 586e51a60fabf-3c0f5d13930mr13019224fac.4.1760517815138;
        Wed, 15 Oct 2025 01:43:35 -0700 (PDT)
Received: from SN6PR04MB4048.namprd04.prod.outlook.com ([2603:1036:805:3e::5])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3c8c8ae8f91sm5234410fac.2.2025.10.15.01.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 01:43:34 -0700 (PDT)
From: Itamar Dalal <dalalitamar@gmail.com>
To: "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "david@redhat.com"
	<david@redhat.com>, "lorenzo.stoakes@oracle.com"
	<lorenzo.stoakes@oracle.com>, "riel@surriel.com" <riel@surriel.com>,
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, "vbabka@suse.cz"
	<vbabka@suse.cz>, "harry.yoo@oracle.com" <harry.yoo@oracle.com>,
	"jannh@google.com" <jannh@google.com>, "rppt@kernel.org" <rppt@kernel.org>,
	"surenb@google.com" <surenb@google.com>, "mhocko@suse.com" <mhocko@suse.com>,
	"shuah@kernel.org" <shuah@kernel.org>
Subject: selftests/mm/rmap: verify correct RMAP handling of COW pages after
 fork()
Thread-Topic: selftests/mm/rmap: verify correct RMAP handling of COW pages
 after fork()
Thread-Index: AQHcPa+FfLpoUZg/p0aSBo0MKrxelg==
X-MS-Exchange-MessageSentRepresentingType: 1
Date: Wed, 15 Oct 2025 08:43:33 +0000
Message-ID:
	<SN6PR04MB4048CF9A242A640B29A588EDFEE8A@SN6PR04MB4048.namprd04.prod.outlook.com>
Accept-Language: en-US, he-IL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-Exchange-Organization-SCL: -1
X-MS-TNEF-Correlator:
X-MS-Exchange-Organization-RecordReviewCfmType: 0
msip_labels:
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Add a new test `migrate.cow_after_fork` that verifies correct RMAP handling=
=0A=
of Copy-On-Write (COW) pages after fork().=0A=
=0A=
Before a write, the parent and child share the same PFN. After a write, the=
=0A=
child=92s PFN differs. This confirms that proper COW duplication occurred a=
nd=0A=
that RMAP correctly tracks page ownership transitions during COW events.=0A=
=0A=
Signed-off-by: Itamar-Dalal <dalalitamar@gmail.com>=0A=
---=0A=
 tools/testing/selftests/mm/rmap.c | 45 ++++++++++++++++++++++++++++++-=0A=
 1 file changed, 44 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/tools/testing/selftests/mm/rmap.c b/tools/testing/selftests/mm=
/rmap.c=0A=
index 13f7bccfd0a9..2ba3361fecf0 100644=0A=
--- a/tools/testing/selftests/mm/rmap.c=0A=
+++ b/tools/testing/selftests/mm/rmap.c=0A=
@@ -430,4 +430,47 @@ TEST_F(migrate, ksm)=0A=
        propagate_children(_metadata, data);=0A=
 }=0A=
=0A=
-TEST_HARNESS_MAIN=0A=
+TEST_F(migrate, cow_after_fork)=0A=
+{=0A=
+       struct global_data *data =3D &self->data;=0A=
+       int status;=0A=
+       pid_t pid;=0A=
+       unsigned long parent_pfn, child_pfn;=0A=
+       int pagemap_fd;=0A=
+       char *region;=0A=
+=0A=
+       /* Map private anonymous memory and fault it in */=0A=
+       region =3D mmap(NULL, data->mapsize, PROT_READ | PROT_WRITE,=0A=
+               MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);=0A=
+       ASSERT_NE(region, MAP_FAILED);=0A=
+       memset(region, 0xaa, data->mapsize);=0A=
+=0A=
+       pagemap_fd =3D open("/proc/self/pagemap", O_RDONLY);=0A=
+       ASSERT_NE(pagemap_fd, -1);=0A=
+       parent_pfn =3D pagemap_get_pfn(pagemap_fd, region);=0A=
+       close(pagemap_fd);=0A=
+=0A=
+       pid =3D fork();=0A=
+       ASSERT_NE(pid, -1);=0A=
+=0A=
+       if (pid =3D=3D 0) {=0A=
+               /* Child: write to trigger COW */=0A=
+               region[0] =3D 0xbb;=0A=
+=0A=
+               pagemap_fd =3D open("/proc/self/pagemap", O_RDONLY);=0A=
+               ASSERT_NE(pagemap_fd, -1);=0A=
+               child_pfn =3D pagemap_get_pfn(pagemap_fd, region);=0A=
+               close(pagemap_fd);=0A=
+=0A=
+               /* Expect PFN to differ after write (COW happened) */=0A=
+               if (child_pfn =3D=3D parent_pfn)=0A=
+                       _exit(FAIL_ON_CHECK);=0A=
+               _exit(0);=0A=
+       }=0A=
+=0A=
+       waitpid(pid, &status, 0);=0A=
+       ASSERT_EQ(WEXITSTATUS(status), 0);=0A=
+       munmap(region, data->mapsize);=0A=
+}=0A=
+=0A=
+TEST_HARNESS_MAIN=0A=
\ No newline at end of file=0A=
--=0A=
2.34.1=

