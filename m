Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1002435840
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Oct 2021 03:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbhJUBbi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Oct 2021 21:31:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23056 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230268AbhJUBbh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Oct 2021 21:31:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634779762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BlV+ARiKa3/8/9BVagtX9yLh+qMMBcZxVM11x/BzOdk=;
        b=Mx2hFJQaPu/B4NjScnTXPdUamued2IYbdZZ6ucIB7w2bZf40uOlpWp2lyTT0UEPZVjzz/s
        BX8wtEJPbFTjOzc1VsxLCnwB2VGW3xIY0wqWAf2KUMTbWp80x/ejnVrwlMlKXNzNo4qtDI
        vEN+zvwimjIQAtYnOZiyG3vNeA/ERO0=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-553-hLPv2evaNKiTIOE2xv9SMg-1; Wed, 20 Oct 2021 21:29:20 -0400
X-MC-Unique: hLPv2evaNKiTIOE2xv9SMg-1
Received: by mail-pj1-f71.google.com with SMTP id nk17-20020a17090b195100b001a199d7a415so1333749pjb.7
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Oct 2021 18:29:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BlV+ARiKa3/8/9BVagtX9yLh+qMMBcZxVM11x/BzOdk=;
        b=0U16yMTrM8oaFH12zdfHVSEEj5y/UZCGY97EkCVeFJEZ8WXBu+jIOL8YnNBELbFuWS
         0WqylKV0J+Gs/2jyEScQ+893kBiCf0GMhbqS+ezNN/++xPNXpDhudTQ059IcWPdAHZWD
         I/KK71fe8xmWqRCnyMp9WhkTgLyW2AcPvLc/xYOrT2oUtBvcGKrKdBIcC1/JoNdxZ5dJ
         pWsIMakCqPV/KNdCkyPycQ+D4sqPMAnv8hMjtT9OcyXgYSww3dorwcZ4Pq5nBt7ieD8w
         MAxTakMMb/Rnh2Iqd1RX144gZeljtC5I1FfVi+f3j1Mm9/zLUvBGhy6S+TSS4zSGEQhS
         wpHg==
X-Gm-Message-State: AOAM5302el8Z+ZvDWY9EWU5l0maQ+yNfcDj404HoSOOPhCiYtGP+j2sf
        rCL67uyGlY14Wnyq064BFGHJ+hSOD4lqs7E+PXp2QHvaFVb+11tWUKA4yNu1Ry54T7Kr6WOWXSY
        Cr78UhjAiq3myCjm6WLjxmQZe6hiT
X-Received: by 2002:a63:ed4a:: with SMTP id m10mr2119201pgk.448.1634779759750;
        Wed, 20 Oct 2021 18:29:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzLT8cImRwZSUB9vci3AK/6sF9OSUh11r0p4OY2pwmW2mqhL9PPlJb2PmNU10BztrNI3j1fjA==
X-Received: by 2002:a63:ed4a:: with SMTP id m10mr2119185pgk.448.1634779759505;
        Wed, 20 Oct 2021 18:29:19 -0700 (PDT)
Received: from xz-m1.local ([84.17.34.135])
        by smtp.gmail.com with ESMTPSA id p4sm3192782pgc.15.2021.10.20.18.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 18:29:18 -0700 (PDT)
Date:   Thu, 21 Oct 2021 09:29:14 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Linux MM <linux-mm@kvack.org>,
        Linuxkselftest <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] userfaultfd/selftests: fix feature support
 detection
Message-ID: <YXDCagVgh2O2YdIW@xz-m1.local>
References: <20210930212309.4001967-1-axelrasmussen@google.com>
 <20210930212309.4001967-3-axelrasmussen@google.com>
 <CAJHvVcj9FpJgC5EsB1_6yfgDA8p5-=Oakccg+TUrGUWZB5nHzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJHvVcj9FpJgC5EsB1_6yfgDA8p5-=Oakccg+TUrGUWZB5nHzA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Oct 20, 2021 at 11:28:49AM -0700, Axel Rasmussen wrote:
> Just a friendly bump for review. :) Peter, any objections to this
> version? I think it fairly closely matches your suggestions from v1.

Isn't the whole patchset already queued by Andrew? :)

Anyway,

Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks for the change!

-- 
Peter Xu

