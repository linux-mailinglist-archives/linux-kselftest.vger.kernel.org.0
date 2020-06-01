Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 987871EA2FB
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jun 2020 13:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbgFALjh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 1 Jun 2020 07:39:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:58694 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbgFALjh (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 1 Jun 2020 07:39:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 16313AEDE;
        Mon,  1 Jun 2020 11:39:38 +0000 (UTC)
Date:   Mon, 1 Jun 2020 13:39:35 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Yannick Cote <ycote@redhat.com>
cc:     live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        joe.lawrence@redhat.com
Subject: Re: [PATCH 3/4] selftests/livepatch: more verification in
 test-klp-shadow-vars
In-Reply-To: <20200528134849.7890-4-ycote@redhat.com>
Message-ID: <alpine.LSU.2.21.2006011337560.2043@pobox.suse.cz>
References: <20200528134849.7890-1-ycote@redhat.com> <20200528134849.7890-4-ycote@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Noticed one more thing nevertheless...

> +	/* pass 6: free all the <objs[*], SV_ID2> svar pairs too. */
> +	shadow_free_all(SV_ID2, NULL);		/* 'int' pairs */
> +	for (i = 0; i < NUM_OBJS; i++) {
> +		sv = shadow_get(&objs[i], SV_ID2);
> +		if (!sv)
> +			pr_info("  shadow_get() got expected NULL result\n");
> +	}

I think that shadow_get() should be removed from the message to make it 
consistent with the rest.

Miroslav
