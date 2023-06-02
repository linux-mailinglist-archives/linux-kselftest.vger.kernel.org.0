Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51AD77206BA
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jun 2023 18:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235236AbjFBQAj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Jun 2023 12:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234446AbjFBQAj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Jun 2023 12:00:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A6C1AB
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Jun 2023 09:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685721600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WluSeIuvtKhl0MvwyGqfFEArtzh7ptnhCjSpLHHHp9s=;
        b=SdKzTTHimpy4wWVkW8+Kh0wbqPSwBq5P5Za+DLIi2kKW8iC64CHZc2bRa7DWE5u0hnOeaA
        HaRkfgd6azoGQKdcHo0kndyOP1MEWE2Y8xkgUeTRLcexuhcX/JjklbETo0RRVyE9wzR8jP
        1LAZBbiSQSuOANgBtiBE4/XgqI5dzhY=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-BSSBD9IiNaO_1-BXscc-EA-1; Fri, 02 Jun 2023 11:59:58 -0400
X-MC-Unique: BSSBD9IiNaO_1-BXscc-EA-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-3f6b20bc467so2564381cf.0
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Jun 2023 08:59:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685721598; x=1688313598;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WluSeIuvtKhl0MvwyGqfFEArtzh7ptnhCjSpLHHHp9s=;
        b=aHOzU2OasdXCclEArwdx13bd1a48yBltrCpWs4QSItbD3gdFI8eADrwD30xszcIdmo
         QCux02nK5kX/guxXbJCPw0Q2nqTxUbSYxoucg4pzPEspj6HcJ93lPWo+/np4IkSHSJoe
         BWOP0O7p97kf0deVfbnHPEIl0b0Zy3FX/sgmcn8G1OytjamTpb5v6nQc45NsLJy3Fis7
         vCUed+sYXTgv1M2Zbu+r2eNWohG7ZXoFJJqQa6Cd3UP8q9j2MmuUH5iXMLMk83IHxfo1
         Y4vZDe0jniXt8URXvYS9BuXWbBGHeZVOv4/ZXso8vnFm1epmyI78PTdJ80SteWCP8UtK
         xPNA==
X-Gm-Message-State: AC+VfDyOiVk/AL3UaXCw6TbcRXxm59FmX5GOlZI6qYLa9pNtIHGawhio
        5nJlg0p10fZJP8V4ymhHFu2C/4+ayp6fbWRLZq2rrCVP9UlAK0hhwcNNtsDqJl3k0YyUnjEvWg5
        fFiEvx5bJzfHuPj4ChT8Dxfp3gyP8neytdAfQ
X-Received: by 2002:a05:622a:148e:b0:3f6:a9e9:1e96 with SMTP id t14-20020a05622a148e00b003f6a9e91e96mr16819345qtx.2.1685721597810;
        Fri, 02 Jun 2023 08:59:57 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4P+qvQuw+e4EBMOLjOETYwQ3U0i400pZccCzfCIIyuO0UO5Oda35BzCXNcPgaf0G00J0XIqA==
X-Received: by 2002:a05:622a:148e:b0:3f6:a9e9:1e96 with SMTP id t14-20020a05622a148e00b003f6a9e91e96mr16819317qtx.2.1685721597584;
        Fri, 02 Jun 2023 08:59:57 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id p15-20020ac8460f000000b003f7369c7302sm897702qtn.89.2023.06.02.08.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 08:59:56 -0700 (PDT)
Date:   Fri, 2 Jun 2023 11:59:55 -0400
From:   Peter Xu <peterx@redhat.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 10/12] selftests/mm: move uffd* routines from vm_util.c
 to uffd-common.c
Message-ID: <ZHoR+3v+zUENBhi4@x1n>
References: <20230602013358.900637-1-jhubbard@nvidia.com>
 <20230602013358.900637-11-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230602013358.900637-11-jhubbard@nvidia.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jun 01, 2023 at 06:33:56PM -0700, John Hubbard wrote:
> This is where they belong, and this makes it cleaner to apply a
> follow-up fix to the uffd builds.
> 
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

Thanks for further looking into this.

I'm fine to move it over if you think proper, but just to mention I had
those in vm_utils.h just because I left all uffd specific tests shared code
in uffd-common.h, so my plan was uffd-common.h shouldn't be included in
most test cases except uffd tests.

I'm not sure whether we can just make your next patch of "ifndef.." into
vm_utils.h to avoid the movement, or is it a must?

Thanks,

-- 
Peter Xu

