Return-Path: <linux-kselftest+bounces-23192-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3E89ED692
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 20:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E772B16538D
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 19:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64511DB933;
	Wed, 11 Dec 2024 19:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xxwi7ZEZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91CD1C3F04
	for <linux-kselftest@vger.kernel.org>; Wed, 11 Dec 2024 19:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733945836; cv=none; b=hoIHmZCtmNlTtP69R8zaUMLR/Hho/rbrWc8KMN4BfUkEJlTvfHNzPBy3oSkWC+Cu7T75aP+/mh8GIbBelCxn3SFAf3g4/90FuJz/6YtgbM4Cf+ZHNJpZxxk/x4CYq//s3k9Ripe0YxHC1Q+BlNXHQwG5hsuEh2IG8rRLdkSM3YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733945836; c=relaxed/simple;
	bh=lVK40u0NyAfMbrlw+Wot+Edtg9b69WswtVo/MNtnMCE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=lwuCGSnmPMUGqDbZI7oVBu6RI1niYX4+H6oM3cQtEtDxfNoVfjgCmkGSEjXvqNw2YWnS6JQbmMkcyK45+EOOK8TEpPkBRyebWWEi14eysKnVqKzfMEISwSVw8WcE03QtJtkoDps1bvKRDgffwR9F3FtUfvVWERJ5uSUvwgGabi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xxwi7ZEZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733945833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=i8/gFxZSvxzNzKpmlho1MeQRhcbvE6K9wGI4pejJiGQ=;
	b=Xxwi7ZEZ8kwUfo+Mww6qa4R68Kumz21mXRWpKanNHkwB5sm6JS3CByBhkzGEniAGIPtQrU
	y+CXtl+68zaVF/WGCci+QTMaZhwDXRR55zS8Beto3sSaXQahxhfBpLB6n6osQIlmgpWFzx
	JtHIBITZnB7maG0rlV1FjG+hZfP+f0I=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-364-o-w4vmeXM9-yvenBzSaQOQ-1; Wed,
 11 Dec 2024 14:37:10 -0500
X-MC-Unique: o-w4vmeXM9-yvenBzSaQOQ-1
X-Mimecast-MFC-AGG-ID: o-w4vmeXM9-yvenBzSaQOQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8098E1955DCB;
	Wed, 11 Dec 2024 19:37:09 +0000 (UTC)
Received: from starship.lan (unknown [10.22.82.46])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 242731956048;
	Wed, 11 Dec 2024 19:37:07 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: kvm@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	Maxim Levitsky <mlevitsk@redhat.com>
Subject: [PATCH 0/4] KVM: selftests: dirty_log_test: fixes for running the test nested
Date: Wed, 11 Dec 2024 14:37:02 -0500
Message-Id: <20241211193706.469817-1-mlevitsk@redhat.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

As a part of the effort to start running kvm selftests nested, this patch=0D
series contains several fixes to the dirty_log_test, which allows this test=
=0D
to run nested very well.=0D
=0D
I also included a mostly nop change to KVM, to reverse the order in which=0D
the PML log is read to align more closely to the hardware. It should=0D
not affect regular users of the dirty logging but it fixes a unit test=0D
specific assumption in the dirty_log_test dirty-ring mode.=0D
=0D
Patch 4 fixes a very rare problem, which is hard to reproduce with standard=
=0D
test parameters, but due to some weird timing issue, it=0D
actually happened a few times on my machine which prompted me to investigat=
e=0D
it.=0D
=0D
The issue can be reproduced well by running the test nested=0D
(without patch 4 applied) with a very short iteration time and with a=0D
few iterations in a loop like this:=0D
=0D
while ./dirty_log_test -i 10 -I 1 -M dirty-ring ; do true ; done=0D
=0D
Or even better, it's possible to manually patch the test to not wait at all=
=0D
(effectively setting iteration time to 0), then it fails pretty fast.=0D
=0D
Best regards,=0D
       Maxim Levitsky=0D
=0D
Maxim Levitsky (4):=0D
  KVM: VMX: read the PML log in the same order as it was written=0D
  KVM: selftests: dirty_log_test: Limit s390x workaround to s390x=0D
  KVM: selftests: dirty_log_test: run the guest until some dirty ring=0D
    entries were harvested=0D
  KVM: selftests: dirty_log_test: support multiple write retires=0D
=0D
 arch/x86/kvm/vmx/vmx.c                       | 32 +++++---=0D
 arch/x86/kvm/vmx/vmx.h                       |  1 +=0D
 tools/testing/selftests/kvm/dirty_log_test.c | 79 +++++++++++++++++---=0D
 3 files changed, 91 insertions(+), 21 deletions(-)=0D
=0D
-- =0D
2.26.3=0D
=0D


