Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EABEA1CB678
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 May 2020 20:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbgEHSBp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 May 2020 14:01:45 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33610 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726746AbgEHSBp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 May 2020 14:01:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588960904;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4KnJZqptJ7bWIQFTnBFMgLlZZljmdsRpqDipOGzc+e4=;
        b=Lx+XrSiPMRWJEUN19vKXI+s1QBugwVCNYubkP/sF5e77zvLMQD3Q6VvN0oHOJ7uA9pdNbE
        1ek9loLwZPv4go7iBnje93Ydv/XmTPJGdnbMVGoVl7rYWQqKuKWLRU0tGhVDB2pvfrjV8t
        o6kKkxjVt12y6t1TBoGV44TdTlL26zA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-TtcT3JbAOVKRvwqRdpnw9w-1; Fri, 08 May 2020 14:01:40 -0400
X-MC-Unique: TtcT3JbAOVKRvwqRdpnw9w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 09FAE1895A28;
        Fri,  8 May 2020 18:01:38 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-113-187.ams2.redhat.com [10.36.113.187])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E9C465C297;
        Fri,  8 May 2020 18:01:35 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Sandipan Das <sandipan@linux.ibm.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linuxram@us.ibm.com, aneesh.kumar@linux.ibm.com,
        bauerman@linux.ibm.com, mpe@ellerman.id.au
Subject: Re: [PATCH 2/2] selftests: vm: pkeys: Fix powerpc access right updates
References: <cover.1588959697.git.sandipan@linux.ibm.com>
        <cover.1588959697.git.sandipan@linux.ibm.com>
        <5f65cf37be993760de8112a88da194e3ccbb2bf8.1588959697.git.sandipan@linux.ibm.com>
Date:   Fri, 08 May 2020 20:01:34 +0200
In-Reply-To: <5f65cf37be993760de8112a88da194e3ccbb2bf8.1588959697.git.sandipan@linux.ibm.com>
        (Sandipan Das's message of "Fri, 8 May 2020 23:19:15 +0530")
Message-ID: <87blmymhkx.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

* Sandipan Das:

> The Power ISA mandates that all writes to the Authority
> Mask Register (AMR) must always be preceded as well as
> succeeded by a context-synchronizing instruction. This
> applies to both the privileged and unprivileged variants
> of the Move To AMR instruction.

Ugh.  Do you have a reference for that?

We need to fix this in glibc.

Thanks,
Florian

