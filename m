Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68585720647
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jun 2023 17:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235809AbjFBPfF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Jun 2023 11:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236339AbjFBPfE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Jun 2023 11:35:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6529F18C
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Jun 2023 08:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685720054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uD2qZ/qBPDgZT2JpIjaNujnRPmSBG4jkPCjfmwc9oFg=;
        b=bQ545N8KGkDOSPPnh3fgwVB0+gU8KHtr+tdo555h+ePFrpp3dX1H7GtO8P7XytPZOgoPfZ
        qvPbjXJxJbr1mh87lwvUDNNQ0xFm6Pop1V/7iChwHWjqQoi2+vh1QtnO4eXOBHt1yMtElO
        BaLVIvsezIk+fxpG2hztZOUrIZT6dMk=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-50uJykzTOS-4q8eg9TzKEA-1; Fri, 02 Jun 2023 11:34:13 -0400
X-MC-Unique: 50uJykzTOS-4q8eg9TzKEA-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-62632620f00so2251496d6.0
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Jun 2023 08:34:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685720053; x=1688312053;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uD2qZ/qBPDgZT2JpIjaNujnRPmSBG4jkPCjfmwc9oFg=;
        b=Bc9UEpiTSmgIU3UNV0zSaEFWu/Xwy65iM3/mym+y1VjAZLmUaV/wZ6clsASsV5oKfz
         JjgUF1aIsK+F971IzFSaiaYyPnIh4zIf7P6bS73IhF18EHW5GhjLjvW7IcSMkDkTpGtp
         pm4TaL0uy/P/Dus/6eo1rL+rv2KYvkEUyhjGMCUWqu80iM3gHVL93IFBmp22p/fdXvaR
         rsljtZIug86CXO7TblbXFCnGCbjMuUKAv0uOMdvaeQskrho7GT71ZhdLQIj9qA4SFvwx
         YJsjQkdoW8uSddCOvbwwTTrlU6tJkJDfIpLhLtqumcaU1rZd+70xU1NWbiyN7xm9BL4x
         W3yg==
X-Gm-Message-State: AC+VfDwhZnDi5qLOfk49xD0JS6woVzkNXaCqVtQqhZyswyFBdU55eb8m
        Pcs2ba3jmaz7o8VfmSkvyAI7nJxtqL6IMLTpoj2q7qlFfeTVoSf+jwrOW1+gCbooD67qJUiYfWA
        1M9Qx1hObfXbsmUBF6/h3tGI2Ynox
X-Received: by 2002:a05:6214:27c9:b0:624:dcc5:819f with SMTP id ge9-20020a05621427c900b00624dcc5819fmr14033516qvb.1.1685720052847;
        Fri, 02 Jun 2023 08:34:12 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ67nKBkF1jqjQP2JomHmChO+t94LOD9xFbjI7zyZuubFq3mLRke90T5US2VBjRhPerN+vUzzw==
X-Received: by 2002:a05:6214:27c9:b0:624:dcc5:819f with SMTP id ge9-20020a05621427c900b00624dcc5819fmr14033495qvb.1.1685720052553;
        Fri, 02 Jun 2023 08:34:12 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id p8-20020a0cfd88000000b00623927281c2sm946905qvr.40.2023.06.02.08.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 08:34:11 -0700 (PDT)
Date:   Fri, 2 Jun 2023 11:34:10 -0400
From:   Peter Xu <peterx@redhat.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 05/12] selftests/mm: fix invocation of tests that are run
 via shell scripts
Message-ID: <ZHoL8vJPIUzP2RKN@x1n>
References: <20230602013358.900637-1-jhubbard@nvidia.com>
 <20230602013358.900637-6-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230602013358.900637-6-jhubbard@nvidia.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jun 01, 2023 at 06:33:51PM -0700, John Hubbard wrote:
> We cannot depend upon git to reliably retain the executable bit on shell
> scripts, or so I was told several years ago while working on this same
> run_vmtests.sh script. And sure enough, things such as test_hmm.sh are
> lately failing to run, due to lacking execute permissions.
> 
> A nice clean way to fix this would have been to use TEST_PROGS instead
> of TEST_FILES for the .sh scripts here. That tells the selftest
> framework to run these (and emit a warning if the files are not
> executable, but still run them anyway).
> 
> Unfortunately, run_vmtests.sh has its own run_test() routine, which does
> *not* do the right thing for shell scripts.
> 
> Fix this by explicitly adding "bash" to each of the shell script
> invocations. Leave fixing the overall approach to another day.

Is it possible someone just doesn't have "bash" at all?  I used to only use
"sh" without bash installed I think, but that was not on Linux, so I'm not
sure how much that applies..

Maybe use $(SHELL)?  I saw a bunch of usage in the tree too.

-- 
Peter Xu

