Return-Path: <linux-kselftest+bounces-16144-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A78795CD3B
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Aug 2024 15:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD4631C21630
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Aug 2024 13:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9981865E1;
	Fri, 23 Aug 2024 13:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I9FT776y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6DD38385
	for <linux-kselftest@vger.kernel.org>; Fri, 23 Aug 2024 13:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724418580; cv=none; b=K04UE8+qFgS2M3SKmnEdFh6tqNeWSmq3y158dOYjDxZ+EJyll23rMojy67ttlKhR1ap6RV+ByUT09K2kH/mc9AA5jiJvHKw/WFXgsLlaUPKsKqmU+IhmAVQ4IEcY3E19yLJXsu0d5PqnlqouicftSx4yeZwbFo7WIDeVzLL1LsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724418580; c=relaxed/simple;
	bh=JNBTXOgszcyTZqBN+AE8XXw6QOCX5pndr/bjjWzAzdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ch1sCq50sROCl2uG6RxiH39NLEvj5U+sFDV8c7wWSaxa/ZvsEQAHxk3uhfFhcR6GmyeO4LN8ZXTQ70SCBMKK1kLpm5xZj3dwaz8PCXWqYFyNOuB0MNOp8Evt+CT0VYcUMACZy49J11eE9auQ2qgVLPirBvZBTv7ZOmYTUqSldVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I9FT776y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724418577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EG8mD28rVtONRsnlimsJAZ/ET7pCMxfQdK8h/Nb699Q=;
	b=I9FT776yVzjgja7kvw/0zQHIHWe9OjOjUecj2xZQ7cd//HBSb9DuqA6o0pIVJ0OYLPvCJx
	BMcWozDnLTRGEt5kdDgJi6PL8KkiCDpdka/4DcsTtV28Vm+M/V6aZeBQtNeJlo8CiPecjP
	9DLJ/mecILgH7SrgNrxgVMMGVkUPOiA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-115-5iaSknDlOPOsQhXSKJzi6g-1; Fri,
 23 Aug 2024 09:09:33 -0400
X-MC-Unique: 5iaSknDlOPOsQhXSKJzi6g-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3CFF01956048;
	Fri, 23 Aug 2024 13:09:32 +0000 (UTC)
Received: from sullivan-work (unknown [10.22.16.46])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 90782300019C;
	Fri, 23 Aug 2024 13:09:29 +0000 (UTC)
Date: Fri, 23 Aug 2024 09:09:26 -0400
From: "Ryan B. Sullivan" <rysulliv@redhat.com>
To: Petr Mladek <pmladek@suse.com>
Cc: live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
	jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz,
	joe.lawrence@redhat.com, shuah@kernel.org
Subject: Re: [PATCH] selftests/livepatch: wait for atomic replace to occur
Message-ID: <ZsiKBlEQS0NsKlGR@sullivan-work>
References: <20240822173122.14760-1-rysulliv@redhat.com>
 <Zsh51f3-n842TZHw@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="l0yynbd2qMORgpZl"
Content-Disposition: inline
In-Reply-To: <Zsh51f3-n842TZHw@pathway.suse.cz>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4


--l0yynbd2qMORgpZl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Changes from v2:

Adds:
	Reported-by: CKI Project <cki-project@redhat.com>
	Closes: https://datawarehouse.cki-project.org/kcidb/tests/redhat:1413102084-x86_64-kernel_upt_28

--l0yynbd2qMORgpZl
Content-Type: text/plain; charset=us-ascii
Content-Description: PATCHv3
Content-Disposition: attachment;
	filename="0001-selftests-livepatch-wait-for-atomic-replace-to-occur.patch"

From 9d9bfb21e86a3a79fb92fd22d927329510c6a672 Mon Sep 17 00:00:00 2001
From: Ryan Sullivan <rysulliv@redhat.com>
Date: Thu, 22 Aug 2024 12:19:54 -0400
Subject: [PATCH v3] selftests/livepatch: wait for atomic replace to occur

On some machines with a large number of CPUs there is a sizable delay
between an atomic replace occurring and when sysfs updates accordingly.
This fix uses 'loop_until' to wait for the atomic replace to unload all
previous livepatches.

Reported-by: CKI Project <cki-project@redhat.com>
Closes: https://datawarehouse.cki-project.org/kcidb/tests/redhat:1413102084-x86_64-kernel_upt_28
Signed-off-by: Ryan Sullivan <rysulliv@redhat.com>
---
 tools/testing/selftests/livepatch/test-livepatch.sh | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/livepatch/test-livepatch.sh b/tools/testing/selftests/livepatch/test-livepatch.sh
index 65c9c058458d..bd13257bfdfe 100755
--- a/tools/testing/selftests/livepatch/test-livepatch.sh
+++ b/tools/testing/selftests/livepatch/test-livepatch.sh
@@ -139,11 +139,8 @@ load_lp $MOD_REPLACE replace=1
 grep 'live patched' /proc/cmdline > /dev/kmsg
 grep 'live patched' /proc/meminfo > /dev/kmsg
 
-mods=(/sys/kernel/livepatch/*)
-nmods=${#mods[@]}
-if [ "$nmods" -ne 1 ]; then
-	die "Expecting only one moduled listed, found $nmods"
-fi
+loop_until 'mods=(/sys/kernel/livepatch/*); nmods=${#mods[@]}; [[ "$nmods" -eq 1 ]]' ||
+        die "Expecting only one moduled listed, found $nmods"
 
 # These modules were disabled by the atomic replace
 for mod in $MOD_LIVEPATCH3 $MOD_LIVEPATCH2 $MOD_LIVEPATCH1; do
-- 
2.44.0


--l0yynbd2qMORgpZl--


