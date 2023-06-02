Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E1D7205EE
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jun 2023 17:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236159AbjFBPZm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Jun 2023 11:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235825AbjFBPZl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Jun 2023 11:25:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A89A18C
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Jun 2023 08:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685719496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u2PDs4SunVO+2MWPNXOl+T7ECd2Ru9g5P68mrVaPh/w=;
        b=dLLopFY1tDMSofsiNxgZ62Fs5BZgvPhBGO9hMHa7f6AnrSZuEotlcKUKpfBagr5jvcWl5L
        Y9FCttasmxNUbfXC3tWSx6duSvKYl5DRCer+IfkcFyQK3K6J+ekH8JkGSoJli/UNKGS+J+
        +lQcsZDpNkVduwr2UQi/idj/Cn688Js=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-PvFopdb4PCSZQATwSMk1vA-1; Fri, 02 Jun 2023 11:24:55 -0400
X-MC-Unique: PvFopdb4PCSZQATwSMk1vA-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-75b175cf0d1so26587985a.0
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Jun 2023 08:24:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685719494; x=1688311494;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u2PDs4SunVO+2MWPNXOl+T7ECd2Ru9g5P68mrVaPh/w=;
        b=N9wgHK6f/dZyPABzICpGLol7rtDGMwTmfrVxoqISMVaGRhuPUPuQEvd9YNd5O2GTMT
         7/1qbq7kCBdr9j6E789ilTxARnfaGMM6p0K+76IRoTU7egoROF5xP4n2fSYkfLgR4Pvx
         EmqfRHENmoAh2QRTwDi/7BFS8Hm0IrdzPOPxSgkOWtrUHfFLeR3F0LAKKMLDaYGpapSI
         dqiWcDKkXaotc3TQRU364OgSYVLeR58NNNkIoxOgr0yUVXCCzBvipsYKVWwy4D5MBo7W
         IrngqxPjWwrBT4YcnMFzAndfInNdlOpwEbPGxtwIdHXJSHY1VQSw950yA3UBSxU4mN/+
         wpWw==
X-Gm-Message-State: AC+VfDyQYU7jBMyDwRqghh1gMkp5lllnMTS1vkxD6aeAInJTEWBP6bWw
        ZEKfoHIHfnoQ6V8EiF3jL4KvQPRSjb5gaNQUMVvWAxwTYzSxOiCNPSQzUMZDombhiVBMzL1IMI/
        +9MCGG/h0DLuPmt7YjZKT0XDX+3p31FLL7LLA
X-Received: by 2002:a05:622a:1049:b0:3f6:a7ad:9eef with SMTP id f9-20020a05622a104900b003f6a7ad9eefmr13024760qte.1.1685719494560;
        Fri, 02 Jun 2023 08:24:54 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5KWXTKZehX1V2vuXXGVihNXzRRtyGUEEo9IywE+M4tkATB3MPkqrtxdhXe0HnyzkI0cqvpWA==
X-Received: by 2002:a05:622a:1049:b0:3f6:a7ad:9eef with SMTP id f9-20020a05622a104900b003f6a7ad9eefmr13024738qte.1.1685719494293;
        Fri, 02 Jun 2023 08:24:54 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id l14-20020ac84cce000000b003e8160cf93asm872496qtv.80.2023.06.02.08.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 08:24:53 -0700 (PDT)
Date:   Fri, 2 Jun 2023 11:24:52 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 04/12] selftests/mm: fix a char* assignment in
 mlock2-tests.c
Message-ID: <ZHoJxAWtwBo33l6B@x1n>
References: <20230602013358.900637-1-jhubbard@nvidia.com>
 <20230602013358.900637-5-jhubbard@nvidia.com>
 <18e69073-1007-07d8-bf0d-5f400ecab8ea@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <18e69073-1007-07d8-bf0d-5f400ecab8ea@redhat.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jun 02, 2023 at 12:04:57PM +0200, David Hildenbrand wrote:
> On 02.06.23 03:33, John Hubbard wrote:
> > The stop variable is a char*, so use "\0" when assigning to it, rather
> > than attempting to assign a character type. This was generating a
> > warning when compiling with clang.
> > 
> > Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> > ---
> >   tools/testing/selftests/mm/mlock2-tests.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/mm/mlock2-tests.c b/tools/testing/selftests/mm/mlock2-tests.c
> > index 11b2301f3aa3..8ee95077dc25 100644
> > --- a/tools/testing/selftests/mm/mlock2-tests.c
> > +++ b/tools/testing/selftests/mm/mlock2-tests.c
> > @@ -50,7 +50,7 @@ static int get_vm_area(unsigned long addr, struct vm_boundaries *area)
> >   			printf("cannot parse /proc/self/maps\n");
> >   			goto out;
> >   		}
> > -		stop = '\0';
> > +		stop = "\0";
> >   		sscanf(line, "%lx", &start);
> >   		sscanf(end_addr, "%lx", &end);
> 
> 
> I'm probably missing something, but what is the stop variable supposed to do
> here? It's completely unused, no?
> 
> if (!strchr(end_addr, ' ')) {
> 	printf("cannot parse /proc/self/maps\n");
> 	goto out;
> }

I guess it wanted to do "*stop = '\0'" but it just didn't matter a lot
since the sscanf() just worked..

-- 
Peter Xu

