Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBD547E08E
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Dec 2021 09:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346986AbhLWImD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Dec 2021 03:42:03 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:49994 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239194AbhLWImC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Dec 2021 03:42:02 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2FAA91F38A;
        Thu, 23 Dec 2021 08:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1640248921;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mVzBkfCiZhGKEEUEAsMg7AXPFS0Tl2snzCE0PSlakvA=;
        b=tzwZk8CjMmdq4z3NKhAm9muERQRt9TkJVd8tcHnblPxoKNXbw+zZJYiOe0suy8Wb2v8Mx/
        jf05TsOALZpBKYyUYueTvpc9jGduyA1NISbnFGNnYUwAOi8PodjgBOR7P3k9jiYCAfjwsz
        R3gvTo7JAnFqQPBib24QMh2Tih5hR/Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1640248921;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mVzBkfCiZhGKEEUEAsMg7AXPFS0Tl2snzCE0PSlakvA=;
        b=iDWNmlC+hPoyhJuMR7q2mAw4Zj4S3AQ1NTADi8ueKs+1VdTgNwwnmwu4w7n93Jwm7sf74s
        oEYrnDTZzpoGrcCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C8E4713E82;
        Thu, 23 Dec 2021 08:42:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iEPsLlg2xGF3aQAAMHmgww
        (envelope-from <pvorel@suse.cz>); Thu, 23 Dec 2021 08:42:00 +0000
Date:   Thu, 23 Dec 2021 09:41:59 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        Nageswara Sastry <rnsastry@linux.ibm.com>,
        Takashi Iwai <tiwai@suse.de>, Joey Lee <jlee@suse.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] selftest/kexec: fix "ignored null byte in input"
 warning
Message-ID: <YcQ2V8JmGkowEwQ5@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20211222213052.6771-1-zohar@linux.ibm.com>
 <20211222213052.6771-2-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211222213052.6771-2-zohar@linux.ibm.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Mimi,

> Instead of assigning the string to a variable, which might contain a
> null character, redirect the output and grep for the string directly.

Looks reasonable to me.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr
