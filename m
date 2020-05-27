Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7705D1E3A90
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 May 2020 09:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729284AbgE0Haa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 May 2020 03:30:30 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:59561 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728303AbgE0Haa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 May 2020 03:30:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590564629;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KJg12HshbeS3S4n+Gz11l8DLsUwLiTTOXHbHExc5Tx8=;
        b=MJtPnCmDB6U8sgbQM8uh5f7/m2xwvC52jAMdjJUE/CeCgqoqhDRfimqjjng26J0YksG2xo
        KmMkJX4U6ggun6Ygohjy6COvvoJia9aH3jmG3gNsBFSAAYtcNsEttfo1KfN67BkZkf4+98
        +VSrjeZrLmStCyxaV18W9WaXlHjrcG4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-484-hAc6Y4tkNwiC2nGWyMrzMA-1; Wed, 27 May 2020 03:30:25 -0400
X-MC-Unique: hAc6Y4tkNwiC2nGWyMrzMA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D190618017FD;
        Wed, 27 May 2020 07:30:23 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-114-49.ams2.redhat.com [10.36.114.49])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6135B96FAB;
        Wed, 27 May 2020 07:30:22 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     shuah <shuah@kernel.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kselftest@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: kselftest OOT run_tests
References: <xunyblmcqfuu.fsf@redhat.com>
        <ad5ee014-759c-d0fb-5dc1-f1f25481a453@kernel.org>
Date:   Wed, 27 May 2020 10:30:20 +0300
In-Reply-To: <ad5ee014-759c-d0fb-5dc1-f1f25481a453@kernel.org>
        (shuah@kernel.org's message of "Tue, 26 May 2020 11:13:29 -0600")
Message-ID: <xunytv01omwj.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, shuah!

>>>>> On Tue, 26 May 2020 11:13:29 -0600, shuah   wrote:

 > On 5/25/20 7:55 AM, Yauheni Kaliuta wrote:
 >> Hi!
 >> 
 >> I'm wondering how out of tree check is supposed to work for make
 >> O=dir run_tests from selftests (or make -C ...) directory?
 >> 
 >> (both with 051f278e9d81 ("kbuild: replace KBUILD_SRCTREE with
 >> boolean building_out_of_srctree") and without)
 >> 
 >> make M= ... does not work with run_tests.
 >> 

 > Kselftests run_tests target isn't intended for building and
 > running tests OOT.

But there is code there trying to handle it. All that OUTPUT
related things must be removed if it's broken, right? Can I post
a patch?

 > Also make M= doesn't make sense for them.

Well, M=... at least includes all the makefiles.

 > There is no support to build OOT at the moment. I would like
 > to get a better understanding of your use-case. Can you
 > elaborate?

I care about make install actually. But fixing it I had to deal
with OUTPUT. Looking a proper for that I found that it's a bit
broken.


-- 
WBR,
Yauheni Kaliuta

