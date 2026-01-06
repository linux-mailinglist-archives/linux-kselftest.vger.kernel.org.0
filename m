Return-Path: <linux-kselftest+bounces-48299-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 17877CF89A3
	for <lists+linux-kselftest@lfdr.de>; Tue, 06 Jan 2026 14:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 873AD3009263
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jan 2026 13:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75EEF33D6F8;
	Tue,  6 Jan 2026 13:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RgFsFoyt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1B8332ECD
	for <linux-kselftest@vger.kernel.org>; Tue,  6 Jan 2026 13:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767707445; cv=none; b=fNGnLJJ4zsEuqoWZEreCmEVn+MKee9bnESFzU2bSNQ3UlR4OUivpsi3Xh0cUTZ/E23h+sb38ugUHHFueJAYiRwwL4YAHCyQmfJnS+3fG8tWKZz0tiG+yy6r/APtaKAETAEfpnwVagwQHuff+wuDKUVWT1l9PCgvHbkI9fqTS0nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767707445; c=relaxed/simple;
	bh=SDRr1Wj1Va5WJG95OGHMrz/C16ecv2M2apsaa+qwgD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G5CXimT3BRFjOyIeIrU5GAPOn8+QeohddIsBxpcaPXuMueWlMa6rgC9P2sBWUzr3/05X87qRKta4cIglrr39vSVVc9jVQPeoJH7aUM9/ovut9wFUjEXIfmlcBTHNc8FYPzNTgFDYpIKCPaHRVYY2lFmdPQBvLXkGL5vfq6OU/9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RgFsFoyt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767707441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zkrDS5gT4j7HgMEjAMsO5n2pFFiiI6UUin657vMlU7Y=;
	b=RgFsFoytN7ygAn/51OZh1on97Poh5pPxlOWSxHTOFisrVE9T4JqfZtm5/z8LuY74094vPu
	M8Z3RpCvMXUYSjIYASV9wl/Edo/dijH/escLh9dKUmqCxFvxx9bmtk1jcs6QoQ2wU2uImh
	5i3bo+229pvtPRPns6pEWxaL1zRWJvA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-255-DEwN0yyCMguG92sN-1MApQ-1; Tue,
 06 Jan 2026 08:50:35 -0500
X-MC-Unique: DEwN0yyCMguG92sN-1MApQ-1
X-Mimecast-MFC-AGG-ID: DEwN0yyCMguG92sN-1MApQ_1767707434
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3E045195FCDC;
	Tue,  6 Jan 2026 13:50:34 +0000 (UTC)
Received: from fedora (unknown [10.72.116.130])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 26C8E1956048;
	Tue,  6 Jan 2026 13:50:27 +0000 (UTC)
Date: Tue, 6 Jan 2026 21:50:22 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Shuah Khan <shuah@kernel.org>,
	linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v3 13/19] selftests: ublk: add utility to get block
 device metadata size
Message-ID: <aV0THiUJ0S1l8FNC@fedora>
References: <20260106005752.3784925-1-csander@purestorage.com>
 <20260106005752.3784925-14-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260106005752.3784925-14-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Mon, Jan 05, 2026 at 05:57:45PM -0700, Caleb Sander Mateos wrote:
> Some block device integrity parameters are available in sysfs, but
> others are only accessible using the FS_IOC_GETLBMD_CAP ioctl. Add a
> metadata_size utility program to print out the logical block metadata
> size, PI offset, and PI size within the metadata. Example output:
> $ metadata_size /dev/ublkb0
> metadata_size: 64
> pi_offset: 56
> pi_tuple_size: 8
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> ---
>  tools/testing/selftests/ublk/Makefile        |  4 +--
>  tools/testing/selftests/ublk/metadata_size.c | 36 ++++++++++++++++++++
>  2 files changed, 38 insertions(+), 2 deletions(-)
>  create mode 100644 tools/testing/selftests/ublk/metadata_size.c
> 
> diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
> index 06ba6fde098d..41f776bb86a6 100644
> --- a/tools/testing/selftests/ublk/Makefile
> +++ b/tools/testing/selftests/ublk/Makefile
> @@ -47,14 +47,14 @@ TEST_PROGS += test_stress_03.sh
>  TEST_PROGS += test_stress_04.sh
>  TEST_PROGS += test_stress_05.sh
>  TEST_PROGS += test_stress_06.sh
>  TEST_PROGS += test_stress_07.sh
>  
> -TEST_GEN_PROGS_EXTENDED = kublk
> +TEST_GEN_PROGS_EXTENDED = kublk metadata_size
>  
>  LOCAL_HDRS += $(wildcard *.h)
>  include ../lib.mk
>  
> -$(TEST_GEN_PROGS_EXTENDED): $(wildcard *.c)
> +$(OUTPUT)/kublk: common.c fault_inject.c file_backed.c kublk.c null.c stripe.c

I feel wildcard is pretty handy, can we avoid to kill it? Such as:

STANDALONE_UTILS := metadata_size.c
KUBLK_SRCS := $(filter-out $(STANDALONE_UTILS),$(wildcard *.c))


Thanks, 
Ming


