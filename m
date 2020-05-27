Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C77B1E3AAD
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 May 2020 09:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387479AbgE0HfC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 May 2020 03:35:02 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58592 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387411AbgE0HfC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 May 2020 03:35:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590564900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZbwjASRJbI3bz2Sa93EQMEpbxSKJeZZz/Cew21eGuos=;
        b=h3NnunSKsuMukeqPVbDDSNLpLimLwB64tAQqPOy9UsjciIYfLqXs6OusSSkneAXaSlTpms
        H+t4fxbGYXlReoIqnyEv2jlvWuPn98mgKxgzsNtmw4g6Y44f4ErzD9OyswykYQWtHv+zbF
        PXvXqveh1fN0LDAqyv9UQxWaY50dcd4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-b-k8L9I1NqKXiANL3iqLPg-1; Wed, 27 May 2020 03:34:59 -0400
X-MC-Unique: b-k8L9I1NqKXiANL3iqLPg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 14BC48014D7;
        Wed, 27 May 2020 07:34:58 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-114-49.ams2.redhat.com [10.36.114.49])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A8E866C77F;
        Wed, 27 May 2020 07:34:53 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     Joe Lawrence <joe.lawrence@redhat.com>
Cc:     shuah <shuah@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kselftest@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: kselftest OOT run_tests
References: <xunyblmcqfuu.fsf@redhat.com>
        <ad5ee014-759c-d0fb-5dc1-f1f25481a453@kernel.org>
        <fcd9debe-4bed-df1a-d5ea-69e0a8d0ac98@redhat.com>
Date:   Wed, 27 May 2020 10:34:51 +0300
In-Reply-To: <fcd9debe-4bed-df1a-d5ea-69e0a8d0ac98@redhat.com> (Joe Lawrence's
        message of "Tue, 26 May 2020 16:40:06 -0400")
Message-ID: <xunypnapomp0.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Joe!

>>>>> On Tue, 26 May 2020 16:40:06 -0400, Joe Lawrence  wrote:

 > On 5/26/20 1:13 PM, shuah wrote:
 >> On 5/25/20 7:55 AM, Yauheni Kaliuta wrote:
 >>> Hi!
 >>> 
 >>> I'm wondering how out of tree check is supposed to work for make
 >>> O=dir run_tests from selftests (or make -C ...) directory?
 >>> 
 >>> (both with 051f278e9d81 ("kbuild: replace KBUILD_SRCTREE with
 >>> boolean building_out_of_srctree") and without)
 >>> 
 >>> make M= ... does not work with run_tests.
 >>> 
 >> 
 >> Kselftests run_tests target isn't intended for building and running
 >> tests OOT. Also make M= doesn't make sense for them.
 >> 
 >> There is no support to build OOT at the moment. I would like to get
 >> a better understanding of your use-case. Can you elaborate?
 >> 

 > Hey Yauheni, can you CC me on the use-case explanation?

 > We currently do something really silly for the livepatch
 > selftests on RHEL-7 for CKI that requires building them as
 > pseudo OOT... in our case, we'd like to just be able to do
 > something like make modules_prepare && make M= lib/livepatch,
 > so perhaps a bit different... but I'd be curious for which
 > problem you're currently trying to solve.

I care about `make install` for tests at the moment, for CI. For
CI you need to build kernel, install (and save/pack) the tests,
then boot the kernel and run the tests. It deals with OUTPUT, I
looked how to do it properly and found what I found.

My understanding, that it was supposed to work the way you
described. But looks like I'm wrong.


-- 
WBR,
Yauheni Kaliuta

