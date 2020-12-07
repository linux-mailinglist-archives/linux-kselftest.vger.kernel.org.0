Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0CC2D16F8
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Dec 2020 17:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbgLGQ5g (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Dec 2020 11:57:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20230 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727128AbgLGQ5g (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Dec 2020 11:57:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607360169;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TL6ePzwnUJ23W39OpdfafXqwxU8F5GgHEtsegtnBJFQ=;
        b=cedtbKORnGkDOYcz9g8gHW0qAZTxgjDCkT8f6E3Pq3r8E+PLtycEiOnXocaNTykz7H+HR2
        b3Lcy1rOQT8uV+VZOqe8+IY5JA5ncBQx7zhPjpjES5EE+sW4vnIWK+p2/zbHESoti5czYY
        9wgBufi+5Coz8hda/Fp6wj3Ewa3jwEE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-itUbY_ODMUSHo1VTizqoRQ-1; Mon, 07 Dec 2020 11:56:06 -0500
X-MC-Unique: itUbY_ODMUSHo1VTizqoRQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 53F26107ACE3;
        Mon,  7 Dec 2020 16:56:05 +0000 (UTC)
Received: from gondolin (ovpn-113-45.ams2.redhat.com [10.36.113.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EC67D620DE;
        Mon,  7 Dec 2020 16:55:59 +0000 (UTC)
Date:   Mon, 7 Dec 2020 17:55:57 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Collin Walling <walling@linux.ibm.com>
Cc:     kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com,
        borntraeger@de.ibm.com, pbonzini@redhat.com, imbrenda@linux.ibm.com
Subject: Re: [PATCH v4] self_tests/kvm: sync_regs test for diag318
Message-ID: <20201207175557.674236b3.cohuck@redhat.com>
In-Reply-To: <20201207154125.10322-1-walling@linux.ibm.com>
References: <20201207154125.10322-1-walling@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon,  7 Dec 2020 10:41:25 -0500
Collin Walling <walling@linux.ibm.com> wrote:

> The DIAGNOSE 0x0318 instruction, unique to s390x, is a privileged call
> that must be intercepted via SIE, handled in userspace, and the
> information set by the instruction is communicated back to KVM.
> 
> To test the instruction interception, an ad-hoc handler is defined which
> simply has a VM execute the instruction and then userspace will extract
> the necessary info. The handler is defined such that the instruction
> invocation occurs only once. It is up to the caller to determine how the
> info returned by this handler should be used.
> 
> The diag318 info is communicated from userspace to KVM via a sync_regs
> call. This is tested During a sync_regs test, where the diag318 info is

s/During/during/

> requested via the handler, then the info is stored in the appropriate
> register in KVM via a sync registers call.
> 
> If KVM does not support diag318, then the tests will print a message
> stating that diag318 was skipped, and the asserts will simply test
> against a value of 0.
> 
> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> ---
>  tools/testing/selftests/kvm/Makefile          |  2 +-
>  .../kvm/include/s390x/diag318_test_handler.h  | 13 +++
>  .../kvm/lib/s390x/diag318_test_handler.c      | 82 +++++++++++++++++++
>  .../selftests/kvm/s390x/sync_regs_test.c      | 16 +++-
>  4 files changed, 111 insertions(+), 2 deletions(-)
>  create mode 100644 tools/testing/selftests/kvm/include/s390x/diag318_test_handler.h
>  create mode 100644 tools/testing/selftests/kvm/lib/s390x/diag318_test_handler.c

Looks reasonable to me.

Acked-by: Cornelia Huck <cohuck@redhat.com>

