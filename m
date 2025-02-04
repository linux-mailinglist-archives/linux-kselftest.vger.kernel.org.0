Return-Path: <linux-kselftest+bounces-25702-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 856E6A276EE
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 17:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BC913A3C34
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 16:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797D8215197;
	Tue,  4 Feb 2025 16:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PO8SmVP7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3CB481D1
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Feb 2025 16:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738685764; cv=none; b=A6e1eup6PRaU0ui19IKD1YjZpUcV8LxBEndf4snHItHPA6QsFpnGNWahdM9M6muoF78TQG7XajFpAQUpynmanCFxKImUwQqt3+jurYooaryArpBh966F5dwv1GLtb49wUeonEgkwBxFAu5H4jbons7zv8PP0U8kPHieT3H8pMtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738685764; c=relaxed/simple;
	bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iaMNhuZLMEkWCrSvv+ne3zJDWCd1PyCnp6MqZW1DikJOcrVPC2KZ3ECkf15rbaMMnEazqk4p8PTVqeWcxkq/9jrRoKoPWClAhmsmR4JhPl4v/1NMBqMZCV82Lqre17QR9tTPnBqE+8oTfRh428IzqnwvC+Dkk6rZq4NuYVdOBC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PO8SmVP7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738685761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
	b=PO8SmVP762CNgisXAsFOzBTRNENZUeUtmSL9JEMG8hLWwFzMvEwTZ6A/7uCL+kNJBsbdZC
	hsOE26khBmdqcDw7ayC5huVf8+3l+Jr/UkyxP6rgNa2RnQaAuoQ0OFBBoouGuaSZ5H2tUH
	nxpeH2zyjH0BLCA5lHGbs4qbMUrUHmQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-NefMONUHNcaM9JCWy--Unw-1; Tue,
 04 Feb 2025 11:15:58 -0500
X-MC-Unique: NefMONUHNcaM9JCWy--Unw-1
X-Mimecast-MFC-AGG-ID: NefMONUHNcaM9JCWy--Unw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0E25019560A1;
	Tue,  4 Feb 2025 16:15:57 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5FECE3003E7F;
	Tue,  4 Feb 2025 16:15:55 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	David Hildenbrand <david@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: selftests: Fix spelling mistake "initally" -> "initially"
Date: Tue,  4 Feb 2025 11:15:53 -0500
Message-ID: <20250204161553.252280-1-pbonzini@redhat.com>
In-Reply-To: <20250204105647.367743-1-colin.i.king@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Queued, thanks.

Paolo



