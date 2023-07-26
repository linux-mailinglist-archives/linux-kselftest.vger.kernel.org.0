Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB6407640C5
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jul 2023 22:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjGZUvk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jul 2023 16:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbjGZUvi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jul 2023 16:51:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043822736;
        Wed, 26 Jul 2023 13:51:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F9EB61CC1;
        Wed, 26 Jul 2023 20:51:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CF61C433C7;
        Wed, 26 Jul 2023 20:51:19 +0000 (UTC)
Date:   Wed, 26 Jul 2023 16:51:16 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ajay Kaher <akaher@vmware.com>
Cc:     shuah@kernel.org, mhiramat@kernel.org, chinglinyu@google.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, lkp@intel.com,
        namit@vmware.com, oe-lkp@lists.linux.dev, amakhalov@vmware.com,
        er.ajay.kaher@gmail.com, srivatsa@csail.mit.edu, tkundu@vmware.com,
        vsirnapalli@vmware.com
Subject: Re: [PATCH v5 06/10] eventfs: Implement eventfs lookup, read, open
 functions
Message-ID: <20230726165116.64664689@rorschach.local.home>
In-Reply-To: <1690054625-31939-7-git-send-email-akaher@vmware.com>
References: <1690054625-31939-1-git-send-email-akaher@vmware.com>
        <1690054625-31939-7-git-send-email-akaher@vmware.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, 23 Jul 2023 01:07:01 +0530
Ajay Kaher <akaher@vmware.com> wrote:

> +void eventfs_set_ef_status_free(struct dentry *dentry)
> +{
> +	struct tracefs_inode *ti_parent;
> +	struct eventfs_file *ef;
> +
> +	mutex_lock(&eventfs_mutex);
> +	ti_parent = get_tracefs(dentry->d_parent->d_inode);
> +	if (!ti_parent || !(ti_parent->flags & TRACEFS_EVENT_INODE))
> +		goto out;
> +
> +	ef = dentry->d_fsdata;
> +	if (!ef)
> +		goto out;
> +


> +	/*
> +	 * If ef was freed, then the LSB bit is set for d_fsdata.
> +	 * But this should not happen, as it should still have a
> +	 * ref count that prevents it. Warn in case it does.
> +	 */
> +	if (WARN_ON_ONCE((unsigned long)ef & 1))
> +		goto out;

Can you add this part to Patch 8: eventfs: Implement removal of meta data from eventfs ?

That way the pointer logic is all added together.

-- Steve


> +
> +	dentry->d_fsdata = NULL;
> +	ef->dentry = NULL;
> +out:
> +	mutex_unlock(&eventfs_mutex);
> +}
> +
