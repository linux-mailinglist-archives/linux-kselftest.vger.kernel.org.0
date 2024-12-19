Return-Path: <linux-kselftest+bounces-23623-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F2E9F878D
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 23:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C5A3164787
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 22:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DBC31D7996;
	Thu, 19 Dec 2024 22:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OJsGdNSr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5741C2304
	for <linux-kselftest@vger.kernel.org>; Thu, 19 Dec 2024 22:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734646248; cv=none; b=jL+rGsqMXOysURvuKHytAcKLSoNai+SMRx9tEMt3u3yoLWEnuTCaMyzYBYouKaXqcEfJD1o0XPi8/YS0FAPVzI2LEqXnSSM5kxjhmkOG17YjH7J470oTwtm67KGKd0TXg2kR+k+HIb8m5zjdaOHKgrgmlwu+64l9G2UfhGEMwlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734646248; c=relaxed/simple;
	bh=jpWDPO9NwvwwErsGWcXatgU2pgUi6oiYVut0uH2FurE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=jj7kAUeODRhM9356nK7VMsbvkcFyJFwEFVUfVVEZ5GqBIhVpXbXBVbfx2Cw1kykEhVhALio5sUdzZEF9GCYV9ZuWeVMyY8J3QacBrO0SxcfM+fYinhSxoEELTgD99lWCq3gAKfqbxvbx4jkv238V8eR6zkwGfYOi2Bg6XucEiUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OJsGdNSr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734646244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ohE6RUMNf4QE7Rf54SYP8XxM1LehvBUEy6S3w5kecBc=;
	b=OJsGdNSra1/SUq0DeC2DWlElK49F8QNadygdzxZ2+OTksxHexovKaLLBKyj13DeoOocrYJ
	uMd9CM/ilcMfP4PoZZ5zgoQAxM8oNRY62371wFSmFPd/cMUCIkRiL06gf1mfynBJsBOJhn
	j1koC8obraCHCAHwSo3APEBoH0M+WiM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-DMrSCFtqMk2Ky6WWoN7NHw-1; Thu,
 19 Dec 2024 17:10:39 -0500
X-MC-Unique: DMrSCFtqMk2Ky6WWoN7NHw-1
X-Mimecast-MFC-AGG-ID: DMrSCFtqMk2Ky6WWoN7NHw
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 30AEA1955DD9;
	Thu, 19 Dec 2024 22:10:37 +0000 (UTC)
Received: from starship.lan (unknown [10.22.65.181])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B6D521953953;
	Thu, 19 Dec 2024 22:10:34 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: kvm@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-kselftest@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Sean Christopherson <seanjc@google.com>,
	Maxim Levitsky <mlevitsk@redhat.com>
Subject: [PATCH v2 0/2] KVM: x86: read the PML log in the same order it was written
Date: Thu, 19 Dec 2024 17:10:32 -0500
Message-Id: <20241219221034.903927-1-mlevitsk@redhat.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Reverse the order in which=0D
the PML log is read to align more closely to the hardware. It should=0D
not affect regular users of the dirty logging but it fixes a unit test=0D
specific assumption in the dirty_log_test dirty-ring mode.=0D
=0D
Best regards,=0D
       Maxim Levitsky=0D
=0D
Maxim Levitsky (2):=0D
  KVM: VMX: refactor PML terminology=0D
  KVM: VMX: read the PML log in the same order as it was written=0D
=0D
 arch/x86/kvm/vmx/main.c   |  2 +-=0D
 arch/x86/kvm/vmx/nested.c |  2 +-=0D
 arch/x86/kvm/vmx/vmx.c    | 32 ++++++++++++++++++++------------=0D
 arch/x86/kvm/vmx/vmx.h    |  5 ++++-=0D
 4 files changed, 26 insertions(+), 15 deletions(-)=0D
=0D
-- =0D
2.26.3=0D
=0D


