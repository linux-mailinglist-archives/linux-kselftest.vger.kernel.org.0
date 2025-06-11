Return-Path: <linux-kselftest+bounces-34753-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC09AD5E18
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 20:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2936173551
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 18:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583ED221732;
	Wed, 11 Jun 2025 18:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XKHX1syt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FF520C494
	for <linux-kselftest@vger.kernel.org>; Wed, 11 Jun 2025 18:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749666463; cv=none; b=Sbm06+LsZ219jBEZNFkM6wA5Nte77eYc9LFQayleM2ef6R67mO1ZYmn1qer6QlvetTNlll5XDsjUNm7AVI4OvDtrAEzawT4bVKcyQ+q3N/78ECSf6NDbvLR31FaouhrDgjfvCBGtDfuPLk4Dpt9kIkeOhC8PIekQ5VFnpo757lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749666463; c=relaxed/simple;
	bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sLroTqp014OLvwqgbOXbj1iqmKx2YfiGhhTVUc107OGogGWyI9mX/C436ev33G2BZ0vWUsPxKLEQY7wpDCjNtvsgVBaagEeWFZcF+j87UUsX+ryhtknHRVMy9pbUVhjOCed+WX93xv8ED/fmKLgtUKKL5T0pJ7EYNesahheVkUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XKHX1syt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749666454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
	b=XKHX1sytk2FI9CDTFaEkt43qUAUCzdu9DozikMx89pzdwXUR6z2sCqKp615LVLzjL+waVV
	nP5LBOklDGsTt19vqheX8fWgPeRGosBNwwWooQBmmvsXH2OsCOuP1Ad+e/urHO6uKRFK0B
	uPECtCtvohmiwwHn7LXyDMWPjnDYBLo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-453-LBJXklAmOW24FrcpQgPxqQ-1; Wed,
 11 Jun 2025 14:27:29 -0400
X-MC-Unique: LBJXklAmOW24FrcpQgPxqQ-1
X-Mimecast-MFC-AGG-ID: LBJXklAmOW24FrcpQgPxqQ_1749666447
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BCE85180026D;
	Wed, 11 Jun 2025 18:27:26 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6365E1956094;
	Wed, 11 Jun 2025 18:27:23 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Ashish Kalra <Ashish.Kalra@amd.com>
Cc: seanjc@google.com,
	pbonzini@redhat.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	thomas.lendacky@amd.com,
	shuah@kernel.org,
	prsampat@amd.com,
	pgonda@google.com,
	nikunj@amd.com,
	pankaj.gupta@amd.com,
	michael.roth@amd.com,
	sraithal@amd.com,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-coco@lists.linux.dev
Subject: Re: [PATCH v3] KVM: SEV: Disable SEV-SNP support on initialization failure
Date: Wed, 11 Jun 2025 14:27:22 -0400
Message-ID: <20250611182722.150019-1-pbonzini@redhat.com>
In-Reply-To: <20250512221634.12045-1-Ashish.Kalra@amd.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Queued, thanks.

Paolo



