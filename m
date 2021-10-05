Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57AB2422821
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Oct 2021 15:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233961AbhJENoz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Oct 2021 09:44:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:56188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233077AbhJENoy (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Oct 2021 09:44:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 81D4861139;
        Tue,  5 Oct 2021 13:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1633441384;
        bh=J3aLC4PyDoCkE6ZBV8EqrCKHmRNUR7xIl7ihhOOIWl4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HE/zEbfQY3VRPURBiiBl3nmNLxbxzIjiG0nNhZFJS4sVTkP3LGwRrZPQoVrxubd9S
         3mnh0WJqJLjJ1SY2uCSdyk+s1qbwmWVYvCoUMIE+IfcKFjTQKuefL6oWlA/f88QIPD
         txTvZU5/4JPNu47XGv/7efwohUNnUVkoeATLd5ME=
Date:   Tue, 5 Oct 2021 15:43:02 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, Alex Shi <alexs@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Shuah Khan <shuah@kernel.org>, Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mike Rapoport <rppt@kernel.org>, x86@kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v1 2/6] mm/memory_hotplug: remove
 CONFIG_MEMORY_HOTPLUG_SPARSE
Message-ID: <YVxWZtQRxTdP2jvX@kroah.com>
References: <20210929143600.49379-1-david@redhat.com>
 <20210929143600.49379-3-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210929143600.49379-3-david@redhat.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Sep 29, 2021 at 04:35:56PM +0200, David Hildenbrand wrote:
> CONFIG_MEMORY_HOTPLUG depends on CONFIG_SPARSEMEM, so there is no need for
> CONFIG_MEMORY_HOTPLUG_SPARSE anymore; adjust all instances to use
> CONFIG_MEMORY_HOTPLUG and remove CONFIG_MEMORY_HOTPLUG_SPARSE.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
