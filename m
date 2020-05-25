Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCC551E0FEC
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 May 2020 15:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403897AbgEYNzO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 May 2020 09:55:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54740 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2403896AbgEYNzO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 May 2020 09:55:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590414913;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=SVF681tuWmjHPWJqOeMK+C0AOeZ6V8i69hpRWb72Bxs=;
        b=aHHmQABEi4DuMNwQl5GBhIAUAsRg8vQm1S/tb1VhMJStNCPi78wd2X+iHwO2HXWlmnYEQ8
        ftZEupp7E95WJel6eMf4x3c/e1G23TKWGZCDtyqXHegMU4JyMxQ48moI56ASgYPK5sWdWC
        wNRH8rqZYG7HBeYnYALVW1bNN9YunJA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-dU_IHBZoOlexVrZg-_mH6A-1; Mon, 25 May 2020 09:55:09 -0400
X-MC-Unique: dU_IHBZoOlexVrZg-_mH6A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CE595100CC85;
        Mon, 25 May 2020 13:55:08 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-114-121.ams2.redhat.com [10.36.114.121])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6B19F5C1BB;
        Mon, 25 May 2020 13:55:07 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        bpf@vger.kernel.org
Subject: kselftest OOT run_tests
Date:   Mon, 25 May 2020 16:55:05 +0300
Message-ID: <xunyblmcqfuu.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi!

I'm wondering how out of tree check is supposed to work for make
O=dir run_tests from selftests (or make -C ...) directory?

(both with 051f278e9d81 ("kbuild: replace KBUILD_SRCTREE with
boolean building_out_of_srctree") and without)

make M= ... does not work with run_tests.

-- 
WBR,
Yauheni Kaliuta

