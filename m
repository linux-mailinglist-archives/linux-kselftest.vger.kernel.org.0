Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FAEF3FC59D
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Aug 2021 12:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240966AbhHaK0k (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 31 Aug 2021 06:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240831AbhHaK0k (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 31 Aug 2021 06:26:40 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78FB2C061575;
        Tue, 31 Aug 2021 03:25:45 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gtucker)
        with ESMTPSA id DA6621F42DE7
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
Subject: Testing & Fuzzing Micro-Conference at Linux Plumbers Conference 2021
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        automated-testing@lists.yoctoproject.org,
        linux-kselftest@vger.kernel.org,
        "kernelci@groups.io" <kernelci@groups.io>,
        syzkaller <syzkaller@googlegroups.com>
Cc:     Sasha Levin <sashal@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Message-ID: <c801f7b9-1f70-e69c-99f6-5bc5c5622991@collabora.com>
Date:   Tue, 31 Aug 2021 11:25:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The Testing & Fuzzing Micro-Conference[1] at Linux Plumbers 2021 will
remain open to new proposals for talks and discussion topics until the
end of next week (Friday 10th Sept).  Please feel free to submit yours
with the "Submit new proposal" form on this page:

  https://linuxplumbersconf.org/event/11/abstracts/

The MC is currently scheduled for Wednesday 22nd.  This is where the
timetable will appear as submissions get accepted:

  https://linuxplumbersconf.org/event/11/sessions/110/#20210922


Last year's edition was very effective in spite of being fully online
rather than in-person.  Topics around testing were mentioned in many
other tracks too, such as real-time and toolchains.  See also the
related KernelCI blog post with community notes[2].  We're looking
forward to having an equally good virtual experience this time again.

Best wishes,
Guillaume


[1] https://www.linuxplumbersconf.org/blog/2021/index.php/2021/07/09/testing-and-fuzzing-microconference-accepted-into-2021-linux-plumbers-conference/

The Testing and Fuzzing microconference focuses on advancing the current
state of testing of the Linux kernel. We aim to create connections
between folks working on similar projects, and help individual projects
make progress.

We ask that any topic discussions will focus on issues/problems they are
facing and possible alternatives to resolving them. The Microconference
is open to all topics related to testing & fuzzing on Linux, not
necessarily in the kernel space.

Suggested topics:

  KernelCI: Extending coverage and improving user experience.
  Growing KCIDB, integrating more sources.
  Better sanitizers: KFENCE, improving KCSAN.
  Using Clang for better testing coverage.
  How to spread KUnit throughout the kernel?
  Testing in-kernel Rust code.

MC leads:

  Sasha Levin <sashal@kernel.org>
  Guillaume Tucker <guillaume.tucker@collabora.com>


[2] https://foundation.kernelci.org/blog/2020/09/23/kernelci-notes-from-plumbers-2020/

