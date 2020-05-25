Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 605F51E06E1
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 May 2020 08:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730446AbgEYG3B (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 May 2020 02:29:01 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30080 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388631AbgEYG3B (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 May 2020 02:29:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590388140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=LGh412eQYr3rCq8xxf45CgrfvWBm+hok9IqBC+gring=;
        b=O0/AIBRocsXfLit747v0ymraNmoRtYvrVUfMv2SveN/Io11s+bnW37vvO2wBaIEqTaoOwS
        xIbErK79Ovr6Acx1Mp3JDCdLSTGvZqAodX4Uryu7Nu+7Rjt9tNhThm8vtU88ucqf+5TFH2
        7ywSUP511OTOtiN5YAK/ws+aEpwao84=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-94-uQ_nYwdtOAuiI16gi10DWA-1; Mon, 25 May 2020 02:28:56 -0400
X-MC-Unique: uQ_nYwdtOAuiI16gi10DWA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 634DA1005510;
        Mon, 25 May 2020 06:28:55 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-112-111.ams2.redhat.com [10.36.112.111])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5810F60CC0;
        Mon, 25 May 2020 06:28:54 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, bpf@vger.kernel.org
Subject: OUTPUT and TEST_CUSTOM_PROGS
Date:   Mon, 25 May 2020 09:28:52 +0300
Message-ID: <xuny367osf2z.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi!

lib.mk expects TEST_GEN_PROGS, TEST_GEN_PROGS_EXTENDED and
TEST_GEN_FILES to be in local directory and tries to handle out
of tree build adding OUTPUT to it at the beginning.

commit be16a244c199 ("selftests: lib.mk: add TEST_CUSTOM_PROGS to
allow custom test run/install") adds TEST_CUSTOM_PROGS but it
handles it differently. Should it add OUTPUT as well?

-- 
WBR,
Yauheni Kaliuta

