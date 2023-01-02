Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30CDF65B507
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jan 2023 17:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233787AbjABQXD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 Jan 2023 11:23:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjABQXC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 Jan 2023 11:23:02 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A50BFA;
        Mon,  2 Jan 2023 08:23:01 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id j17so21377128wrr.7;
        Mon, 02 Jan 2023 08:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JtrZJGG/9ONXWQK8K8EYr6Mu2Yv+AdhTcX6fB6Ad+Ws=;
        b=U8cMgp43zME/UUsV5fYCzziBwgm9TzA66IEzuiUoPXP0yGnS72lyJz4YZCMQXcKETc
         SLipjb0N8trq5AFmoBatrX7h2KOhLnO6DHtIuJrIYQSpCbFOvmiEX6gRtIm9Yo5hulyM
         Eo1ZicNP+ICe9275K8wHpZR1W3ljC+aF1UjdZMgNbppDQtnVIhwUXd0cI+QcjV9yL8Wb
         lCiUXyZeufFQeCUs5TJXw/rD/o08BVnS9zJRvi092Qgq8cqS50xwXHNgT0CCHUWLQXVd
         Y1OzvXt8973O4vU6JOHS+8S+1s8pIanuCXrk3TiDJFJ/LO2HbbuaP2RJPqX5ydMobK0Z
         5Kog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JtrZJGG/9ONXWQK8K8EYr6Mu2Yv+AdhTcX6fB6Ad+Ws=;
        b=xbdjlu25xMKYfTF422IRCr8t4rrVUgHuWZMLHBFS64yAb15X9im+Y2WN2jPK3C7rtE
         aEu8qiOcl6TjXwoadhuxMDG5SzT4lNnGuJRZKvlrtZmdKoKiPGuCKlc4DGdW0hQKvemi
         4BcT6NHImH0CVKB2eHCcAn9/0HHbXv5C0H+YnT7o2hR7LKykNtTO3jXaktgVOYqFL+yD
         1+NRzG0SDtlDNXzk8weJVCaowHyV97diqPfrMKryq+ggAeXIpo5Dh2weey4OL2fdBeV9
         F/pM5KkDvIHaKv8stlAmqmYx/wePpVDA5hQtZbxfu7JzJDFfB/3q++BQr/oiEzTIBCyV
         SKeg==
X-Gm-Message-State: AFqh2ko0nRzCrSblz3swmyq3OxmNqQ3l8m3CzJrHEQIPo3qv8GWvYwlZ
        ywb9xKnV74IPvRHq7Mkqn7o=
X-Google-Smtp-Source: AMrXdXtK3qhbssNb8jaGvY6CuVsLbAHJCxqazo1psLpGKF2hIHrJDpbedrnYj3T3yI6PJ/DheWn4/A==
X-Received: by 2002:a05:6000:18a6:b0:280:4a9:c8dc with SMTP id b6-20020a05600018a600b0028004a9c8dcmr23150483wri.16.1672676580368;
        Mon, 02 Jan 2023 08:23:00 -0800 (PST)
Received: from localhost ([2a01:4c8:469:341:d1e1:a149:58ed:f096])
        by smtp.gmail.com with ESMTPSA id h9-20020adffd49000000b00242209dd1ffsm28897101wrs.41.2023.01.02.08.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 08:22:59 -0800 (PST)
Date:   Mon, 2 Jan 2023 16:22:58 +0000
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Jakub Matena <matenajakub@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v3] selftest/vm: add mremap expand merge offset test
Message-ID: <Y7ME4v00R7ULlxV4@lucifer>
References: <420e491062db9151504aef5661c8a2d928ef6bd7.1672675224.git.lstoakes@gmail.com>
 <9d13393a-d203-23de-30ae-4d6476a94fd7@redhat.com>
 <Y7MBqfYv54rY48Wi@lucifer>
 <f29b6cb0-d46b-7d89-c8ad-12b9addf8ce8@redhat.com>
 <Y7MDVT4dO2pqxJwJ@lucifer>
 <b6b25373-ba6b-6610-1030-7f795f01987c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6b25373-ba6b-6610-1030-7f795f01987c@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jan 02, 2023 at 05:20:49PM +0100, David Hildenbrand wrote:
> Maintainers usually apply tags that are sent to the latest version, when
> picking up the patch. Maintainers usually refrain from going through
> multiple earlier patch versions to pick up tags -- especially, because some
> changes might require a submitter from dropping tags (e.g., bigger changes)
> and the tags might no longer be valid.
>
> So better always include tags when resending, so they don't get lost.
>

Ack, apologies again, and that's completely reasonable. Would you mind adding to
the v4 thread just so we have it? Going forward I'll make sure to propagate the
tags!

Thanks for the review!
