Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E353727F64
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jun 2023 13:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236261AbjFHLvZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Jun 2023 07:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236045AbjFHLvY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Jun 2023 07:51:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E66E6C;
        Thu,  8 Jun 2023 04:51:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 93C0264CD8;
        Thu,  8 Jun 2023 11:51:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6374C433D2;
        Thu,  8 Jun 2023 11:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686225082;
        bh=JZFA/ybxQcOvxs/C01SkmXMMjXuWUvVPOYATnYCc0fE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h4YmX7gA0DQ+0x58Ib+iXoeJcoOIpZxwlrr6dqP8vqI8X/NLrCGhd2lRKyISfnNVN
         TqWYP4cuAALBXAspxB5qn5DTk5xyft0zzoZzhj4MgDP0eFEyw7QMfH7ckH6eoZdDyP
         KiptIlSJQ9221GPxJqV0a2OJalgKSyvXrUBNsZy8=
Date:   Thu, 8 Jun 2023 13:51:19 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Michal Sekletar <msekleta@redhat.com>
Cc:     jirislaby@kernel.org, arozansk@redhat.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
Subject: Re: [PATCH v2 1/2] tty: tty_io: update timestamps on all device nodes
Message-ID: <2023060816-quicken-around-d619@gregkh>
References: <c91c458e-58d0-f13a-9adb-a48a19f82107@kernel.org>
 <20230608101616.44152-1-msekleta@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608101616.44152-1-msekleta@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jun 08, 2023 at 12:16:15PM +0200, Michal Sekletar wrote:
> User space applications watch for timestamp changes on character device
> files in order to determine idle time of a given terminal session. For
> example, "w" program uses this information to populate the IDLE column
> of its output [1]. Similarly, systemd-logind has optional feature where
> it uses atime of the tty character device to determine if there was
> activity on the terminal associated with the logind's session object. If
> there was no activity for a configured period of time then logind will
> terminate such session [2].
> 
> Now, usually (e.g. bash running on the terminal) the use of the terminal
> will update timestamps (atime and mtime) on the corresponding terminal
> character device. However, if access to the terminal, e.g. /dev/pts/0,
> is performed through magic character device /dev/tty then such access
> obviously changes the state of the terminal, however timestamps on the
> device that correspond to the terminal (/dev/pts/0) are not updated.
> 
> This patch makes sure that we update timestamps on *all* character
> devices that correspond to the given tty, because outside observers (w,
> systemd-logind) are maybe checking these timestamps. Obviously, they can
> not check timestamps on /dev/tty as that has per-process meaning.

So how are you protecting this from being an information leak like we
have had in the past where you could monitor how many characters were
being sent to the tty through a proc file?  Seems like now you can just
monitor any tty node in the system and get the same information, while
today you can only do it for the tty devices you have permissions for,
right?

thanks,

greg k-h
