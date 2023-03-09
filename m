Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355C06B1F71
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Mar 2023 10:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbjCIJJd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Mar 2023 04:09:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjCIJJO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Mar 2023 04:09:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C791EFCC
        for <linux-kselftest@vger.kernel.org>; Thu,  9 Mar 2023 01:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678352882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BRkepo0G/I/dl+YsBNN3SwCHdTMQGfCSCw0ryRI4zAQ=;
        b=RCjrHb6oFaqKJDixCnCntuWM354iIRWvsCiZ7DrW5/Yb5JPeXudNXHwt0oElmWkImUuv2T
        T3NGvcmMCAp7Z90zssx9Xc52Ot5202O7msNQlnaQ6Wr7q9h1yrAT6NA0DNOLL1PiB4P5S2
        U7hTVZwcOUHXf7Uew8QAdhTcM4F62x8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-556-ql9adJ74OfOzsDV8rSQOOA-1; Thu, 09 Mar 2023 04:07:58 -0500
X-MC-Unique: ql9adJ74OfOzsDV8rSQOOA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 155BC2807D69;
        Thu,  9 Mar 2023 09:07:58 +0000 (UTC)
Received: from localhost (dhcp-192-239.str.redhat.com [10.33.192.239])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BA9C51121314;
        Thu,  9 Mar 2023 09:07:57 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     Mark Brown <broonie@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] KVM: selftests: Add coverage of MTE system registers
In-Reply-To: <20230308-kvm-arm64-test-mte-regs-v1-1-f92a377e486f@kernel.org>
Organization: Red Hat GmbH
References: <20230308-kvm-arm64-test-mte-regs-v1-1-f92a377e486f@kernel.org>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date:   Thu, 09 Mar 2023 10:07:56 +0100
Message-ID: <878rg6jnrn.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Mar 08 2023, Mark Brown <broonie@kernel.org> wrote:

> Verify that a guest with MTE has access to the MTE registers. Since MTE is
> enabled as a VM wide capability we need to add support for doing that in
> the process.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  tools/testing/selftests/kvm/aarch64/get-reg-list.c | 33 ++++++++++++++++++++++
>  1 file changed, 33 insertions(+)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

