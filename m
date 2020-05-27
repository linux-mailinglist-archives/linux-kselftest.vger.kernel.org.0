Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5271E3A27
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 May 2020 09:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728934AbgE0HQj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 May 2020 03:16:39 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:30062 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728303AbgE0HQi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 May 2020 03:16:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590563797;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=u7x0jTKoQmKpSGjtoUTtN61JtxPAQOe3q2OSG4tdCyk=;
        b=ECwc9VnY+72ItRrJ5ZWX96GlJxdZotFAGo2kWoOYaCQD6jgsdib9PD6Oi+61pxqRQTXQye
        js1gqo4wcGRMtcsN/soaiCC+7usiSy2LAP2PFstvN/iw62NcGula0M/mETHhSOWnND/WfR
        51V0+VkAbrZI9iaJubyDcIvtg1U90BQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-131-RNe6AOL6OFuQk3duszCb6w-1; Wed, 27 May 2020 03:16:34 -0400
X-MC-Unique: RNe6AOL6OFuQk3duszCb6w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 661121855A01;
        Wed, 27 May 2020 07:16:33 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-114-49.ams2.redhat.com [10.36.114.49])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0ECA01A7DB;
        Wed, 27 May 2020 07:16:31 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     linux-kselftest@vger.kernel.org
Cc:     jbenc@redhat.com, Shuah Khan <shuah@kernel.org>,
        bpf@vger.kernel.org
Subject: [RESEND PATCH 0/3] selftests: lib.mk improvements
Date:   Wed, 27 May 2020 10:16:29 +0300
Message-Id: <20200527071629.63364-1-yauheni.kaliuta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Fix 
make[1]: execvp: /bin/sh: Argument list too long

encountered with some shells and a couple of more potential problems
in that part of code.

Yauheni Kaliuta (3):
  selftests: do not use .ONESHELL
  selftests: fix condition in run_tests
  selftests: simplify run_tests

 tools/testing/selftests/lib.mk | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

-- 
2.26.2

