Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84F44590984
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Aug 2022 02:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiHLAUK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 Aug 2022 20:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235855AbiHLAUJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 Aug 2022 20:20:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FC2A0606
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Aug 2022 17:20:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 87356B82335
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Aug 2022 00:20:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 357EEC4347C
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Aug 2022 00:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660263606;
        bh=VcBgOx72SrKAynvtEB4eJUbvGpRlwEh9BrnfUqJELdQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JVt7c5OhLl3xM/d0xvsJ6JkHeJ+ofDIKl0bbUM/iZw2kT9FBlI7jJaXP9FzIAHOdK
         R8dhrZLDj2xnJ4K3Qxefi9pcWOQcHshDEL38roInzSGML3hl6Iy3sjB1PJVTFtrcZo
         o4lWsXNxEczbFgEjMHupsHuQwZEWRNfaylXPp0kmrdbB/l4SdQ/n9e5+syBkt3JlTZ
         KaljiGJyUO+NBzI/b3V3DxM7LFSL4yB0LsO4ynJ+EcZ/JUz+is2BwtStDR6Ucw/lph
         HgTIVrVQcMcRJzRZ5KUQS/n2D8fQtD0Wgb/9yWslaAIcHFo/GQc/xtGOi50vYD/jDU
         +U1/ORcdRpk2w==
Received: by mail-yb1-f179.google.com with SMTP id 21so30764564ybf.4
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Aug 2022 17:20:06 -0700 (PDT)
X-Gm-Message-State: ACgBeo1MaNnaNNjsWQuS6rAjSULa/YlCoxkQH+daQLE6E4AMzMfhZRis
        CsVRsBr7b4KV0mfF145gq/7ac6FZ1UP7lADHR4vYdA==
X-Google-Smtp-Source: AA6agR6dgH9Z0J57ZbSVmYT07RMNRaN2A8XBE58y1N2O6lsg+5CWO9rMzDJgZiq9KCWy3gOsBt3vlp+7vnloPLKLXnU=
X-Received: by 2002:a0d:d282:0:b0:329:74d3:b0da with SMTP id
 u124-20020a0dd282000000b0032974d3b0damr1809994ywd.340.1660263594446; Thu, 11
 Aug 2022 17:19:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220810165932.2143413-1-roberto.sassu@huawei.com> <20220810165932.2143413-5-roberto.sassu@huawei.com>
In-Reply-To: <20220810165932.2143413-5-roberto.sassu@huawei.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Fri, 12 Aug 2022 02:19:43 +0200
X-Gmail-Original-Message-ID: <CACYkzJ6YC_rkX-DFt28_cbSFU23LV4sqq0PL5F6a=NL8GCRdQQ@mail.gmail.com>
Message-ID: <CACYkzJ6YC_rkX-DFt28_cbSFU23LV4sqq0PL5F6a=NL8GCRdQQ@mail.gmail.com>
Subject: Re: [PATCH v10 4/9] KEYS: Move KEY_LOOKUP_ to include/linux/key.h
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, corbet@lwn.net, dhowells@redhat.com,
        jarkko@kernel.org, rostedt@goodmis.org, mingo@redhat.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        shuah@kernel.org, bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Aug 10, 2022 at 6:59 PM Roberto Sassu <roberto.sassu@huawei.com> wrote:
>
> In preparation for the patch that introduces the bpf_lookup_user_key() eBPF
> kfunc, move KEY_LOOKUP_ definitions to include/linux/key.h, to be able to
> validate the kfunc parameters.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Reviewed-by: KP Singh <kpsingh@kernel.org>
