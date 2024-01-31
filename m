Return-Path: <linux-kselftest+bounces-3866-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BB0844689
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 18:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC6DF1C22AE5
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 17:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2FC612DDB8;
	Wed, 31 Jan 2024 17:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XBRke4bb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458FE12DDBA
	for <linux-kselftest@vger.kernel.org>; Wed, 31 Jan 2024 17:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706723570; cv=none; b=F8b9c486W7m+tqrrac8yuO+fgP52I1g7fjXe1bYc2YpxGrW26f4yq3Mc8+KnvVNHLDcqyhlKlQlxjEKAoo34dd9B5rrj+ZZJB5j2yjQfjska/+4yZyNyxhhmhlht6S3AD4ANwBMamiKqxS0ntAD41aC9e0Rg6nuWv2PS8B7uBWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706723570; c=relaxed/simple;
	bh=RLmYU6+ltu3/B/gM7MXhOYw6AX6vPCd2AJldEYNl3tI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qYLV3ZuzU48cXirC974iMmpfU1fUSMpcIyw69C3sHfOzWd6AknTCfbrdZI5JsIrHLkC2TZtXeUGJlwYfVPiOzlanhjRftgdKRI+ZGGJKtslshVRAgQbj/VxYlCdBvqFwNeFtRQ7SiUXV/suE4fNjQGhwGpcJeOhGt6poRR/cgXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XBRke4bb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706723568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HQ/H6X/PPcTUwoATJNGWSbl1/ss2q8lsqvamOf6kns4=;
	b=XBRke4bbMIao3eqNkmM79FHXOihi/jk5bvQDhaD21EWYgKIjZCnrqA/2eBH/o4PqJawD/L
	mYdS+AOmSt5DQNgJRKc7yrvNHg81aV3v3PLogok3NOZhoZn416jZM4ClSotC/nd7nTAwJ6
	DA6++/AuncGI5eGAJFDhjtpC/NFpzkY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-552-PcectawZOXmOgk6BVC2SWg-1; Wed,
 31 Jan 2024 12:52:42 -0500
X-MC-Unique: PcectawZOXmOgk6BVC2SWg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0960C3811F20;
	Wed, 31 Jan 2024 17:52:41 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.202])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3B4DB107BD;
	Wed, 31 Jan 2024 17:52:39 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net 0/3] selftests: net: more fixes
Date: Wed, 31 Jan 2024 18:52:26 +0100
Message-ID: <cover.1706723341.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Another small bunch of fixes, addressing issues outlined by the
netdev CI.

Paolo Abeni (3):
  selftests: net: cut more slack for gro fwd tests.
  selftests: net: fix setup_ns usage in rtnetlink.sh
  selftests: net: enable some more knobs

 tools/testing/selftests/net/config            |  3 +++
 tools/testing/selftests/net/rtnetlink.sh      |  6 ++----
 tools/testing/selftests/net/udpgro_fwd.sh     | 14 ++++++++++++--
 tools/testing/selftests/net/udpgso_bench_rx.c |  2 +-
 4 files changed, 18 insertions(+), 7 deletions(-)

-- 
2.43.0


