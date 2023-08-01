Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1721776AA43
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Aug 2023 09:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbjHAHsc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Aug 2023 03:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbjHAHsc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Aug 2023 03:48:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD165E49
        for <linux-kselftest@vger.kernel.org>; Tue,  1 Aug 2023 00:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690876065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fr3C+UyA3RRBD/kfZAlkA+cHPdjSroXf6vhyShW1as0=;
        b=hM0ZPuixdTGD9gbW4FnGK0FsRlZVSUdgz7J74jxs+rjUc05vRPrsG4cILYA0Dsr2xqfHQ1
        +GnZjdszrZWz6/PuW3mMQAwT/OW9m+K/ocbWwqUcaaVnUflYnGN106YOyKKwZGU8U1JHph
        8tm4hV/8eos8gBCqfZaWiYDPyavoYL4=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-660-YQHCn5bpPjSVlx_Yym5-Qg-1; Tue, 01 Aug 2023 03:47:41 -0400
X-MC-Unique: YQHCn5bpPjSVlx_Yym5-Qg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D21953815EEA;
        Tue,  1 Aug 2023 07:47:40 +0000 (UTC)
Received: from alecto.usersys.redhat.com (unknown [10.43.17.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C8C56492CAC;
        Tue,  1 Aug 2023 07:47:37 +0000 (UTC)
Date:   Tue, 1 Aug 2023 09:47:35 +0200
From:   Artem Savkov <asavkov@redhat.com>
To:     Ruan Jinjie <ruanjinjie@huawei.com>
Cc:     Ast@kernel.org, Daniel@iogearbox.net, Andrii@kernel.org,
        Martin.lau@linux.dev, Song@kernel.org, Yonghong.song@linux.dev,
        John.fastabend@gmail.com, Kpsingh@kernel.org, Sdf@google.com,
        Haoluo@google.com, Jolsa@kernel.org, Mykolal@fb.com,
        Shuah@kernel.org, Benjamin.tissoires@redhat.com, Memxor@gmail.com,
        Iii@linux.ibm.com, Colin.i.king@gmail.com, Awkrail01@gmail.com,
        Rdunlap@infradead.org, Joannelkoong@gmail.com, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH -next v2] selftests/bpf: replace fall through comment by
 fallthrough pseudo-keyword
Message-ID: <20230801074735.GA571679@alecto.usersys.redhat.com>
References: <20230801065447.3609130-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230801065447.3609130-1-ruanjinjie@huawei.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

On Tue, Aug 01, 2023 at 02:54:47PM +0800, Ruan Jinjie wrote:
> Replace the existing /* fall through */ comments with the
> new pseudo-keyword macro fallthrough[1].
> 
> [1] https://www.kernel.org/doc/html/v5.7/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through
> 
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
> ---
> v2:
> - Update the subject and commit message.

I think what Alexei meant was subject-prefix which needs to be
'PATCH bpf-next'. You can read more about patch submission rules
in Documentation/bpf/bpf_devel_QA.rst.

-- 
 Artem

