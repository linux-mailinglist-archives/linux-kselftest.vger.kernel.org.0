Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E25E7D5A54
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Oct 2023 20:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbjJXSVg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Oct 2023 14:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbjJXSVe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Oct 2023 14:21:34 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD7C10D0
        for <linux-kselftest@vger.kernel.org>; Tue, 24 Oct 2023 11:21:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 06C1F21C34;
        Tue, 24 Oct 2023 18:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1698171691; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=LaZmEGe+Z+waYi/8VgtLoiuixxiBvAy1w3IQd4VrOvE=;
        b=rZ7UYq/Q9fGNLM+AdBkgFMqH/RHpz79ZsmTakVaUZV/d0sjhHVrYyfA9oyQPB3HtHdCbmH
        O3B4PRhYukJMthKPGppTukk1gUwmitsfbM3ooUH1KAVut+tzQUoJNTlPxlTeEbHlBmKyHt
        XWe3Axd1Xy3EXc7bTIHaTcqmE1LsZ5w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1698171691;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=LaZmEGe+Z+waYi/8VgtLoiuixxiBvAy1w3IQd4VrOvE=;
        b=e9KF9IG3654FmXgcw7IUvrabCIoVuIEP41enKxcFKQxiuX2YbHqf2HH3fYpM5NtciN9qgN
        I59kD7pBI4AfR+CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 84CA31391C;
        Tue, 24 Oct 2023 18:21:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0ZFpEioLOGUmIQAAMHmgww
        (envelope-from <mpdesouza@suse.com>); Tue, 24 Oct 2023 18:21:30 +0000
Date:   Tue, 24 Oct 2023 15:21:27 -0300
From:   Marcos Paulo de Souza <mpdesouza@suse.de>
To:     linux-kselftest@vger.kernel.org
Cc:     mbenes@suse.cz
Subject: Purpose of gen_tar
Message-ID: <2nv6zlkrhaeosjjtpvsfl5gehrlmujocdbmaxyqgpkxzmjnuuz@cj3bajg37xb7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -3.98
X-Spamd-Result: default: False [-3.98 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         BAYES_HAM(-0.78)[84.49%];
         FROM_HAS_DN(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         TO_DN_NONE(0.00)[];
         DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         RCPT_COUNT_TWO(0.00)[2];
         FORGED_SENDER(0.30)[mpdesouza@suse.de,mpdesouza@suse.com];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_NOT_FQDN(0.50)[];
         RCVD_COUNT_TWO(0.00)[2];
         FROM_NEQ_ENVFROM(0.10)[mpdesouza@suse.de,mpdesouza@suse.com];
         RCVD_TLS_ALL(0.00)[]
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

while testing a new patch on the livepatch kselftests, I was testing the gen_tar
target and I figured that we only copy the resulting binaries to the final tar
file.

Per the kselftests documentation[1], the gen_tar target is used to package the
tests to run "on different systems". But what if the different system has
different libraries/library versions? Wouldn't it be a problem?

This question came when I was working to build the livepatch modules as part of
the kselftests testing suit. The plan was to just package the test
scripts/programs/modules and then run the tests on a different system, likewise
a different SLE version. Since the kernel would be different in this case, I
expected that gen_tar would copy the module source files so they can be compiled
on the target system.

While the current approach can work when the selftests rely solely on shell scripts(cpufreq, kexec),
those who compile userspace binaries (cgroup, alsa, sched, ...) may not work.

Am I missing something? Is gen_tar only meant to copy the tests to be run on
systems with the same libraries or with the libraries with the exactly the same
version?

Thanks in advance,
  Marcos

[1]: https://www.kernel.org/doc/html/latest/dev-tools/kselftest.html
