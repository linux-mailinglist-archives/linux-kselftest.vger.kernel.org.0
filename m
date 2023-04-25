Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2A66EE0C2
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Apr 2023 12:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233737AbjDYK7i (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Apr 2023 06:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjDYK7i (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Apr 2023 06:59:38 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615E24EE2;
        Tue, 25 Apr 2023 03:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682420375; x=1713956375;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8jvvJw41NLmesSY1QPzSG1EXvJzXoQEOc5AL5SNVyxs=;
  b=RHjW6O9W99FYU8Wzz7+3waFab3yG2etdSvuvOQ0f8FsE9iljitBAsWgj
   HLLcsUH0Gp1anWW4WCC/0S/XBp6TxYivJd6ItcRX0qAx0L6JRe3GI+TZC
   mLq1fh9GOUY00QCDN3bIKBGg4Am/eD/iEEZKw0jLe8CAhvaaMP2QC3s6+
   EVfApjmribvcfgDnD2L1ytqKQ3icyqq4TzRf4OukSQT8+tMYH+IwmVmPu
   IMVk5nMSEWGsAPgnXZkgDkn+aT/5s7jt77rl9LrwFQ/8mt5SnI5PPqNIj
   dBX+T3kB+bYDGg26A7DIeXaBtrLF/t9RRsUTux4AKLlKscVjE/Qdkcz+8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="335631399"
X-IronPort-AV: E=Sophos;i="5.99,225,1677571200"; 
   d="scan'208";a="335631399"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2023 03:59:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="687368254"
X-IronPort-AV: E=Sophos;i="5.99,225,1677571200"; 
   d="scan'208";a="687368254"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 25 Apr 2023 03:59:31 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1prGOQ-000jKO-2e;
        Tue, 25 Apr 2023 10:59:30 +0000
Date:   Tue, 25 Apr 2023 18:58:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alan Maguire <alan.maguire@oracle.com>, rostedt@goodmis.org,
        mhiramat@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, corbet@lwn.net, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: Re: [PATCH tracing 1/3] tracing: support > 8 byte array filter
 predicates
Message-ID: <202304251817.eCbqLbrw-lkp@intel.com>
References: <1682414197-13173-2-git-send-email-alan.maguire@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1682414197-13173-2-git-send-email-alan.maguire@oracle.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Alan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.3 next-20230424]
[cannot apply to rostedt-trace/for-next rostedt-trace/for-next-urgent]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alan-Maguire/tracing-support-8-byte-array-filter-predicates/20230425-171832
base:   linus/master
patch link:    https://lore.kernel.org/r/1682414197-13173-2-git-send-email-alan.maguire%40oracle.com
patch subject: [PATCH tracing 1/3] tracing: support > 8 byte array filter predicates
config: parisc-allyesconfig (https://download.01.org/0day-ci/archive/20230425/202304251817.eCbqLbrw-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/d49d8291984dc5ac8933ff406c9f5e56ebbdd4e7
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Alan-Maguire/tracing-support-8-byte-array-filter-predicates/20230425-171832
        git checkout d49d8291984dc5ac8933ff406c9f5e56ebbdd4e7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=parisc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash kernel/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304251817.eCbqLbrw-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/trace/trace_events_filter.c: In function 'predicate_parse':
>> kernel/trace/trace_events_filter.c:628:39: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     628 |                                 kfree((u8 *)prog_stack[i].pred->val);
         |                                       ^
   kernel/trace/trace_events_filter.c: In function 'filter_pred_memcmp':
   kernel/trace/trace_events_filter.c:900:19: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     900 |         u8 *cmp = (u8 *)(pred->val);
         |                   ^
   kernel/trace/trace_events_filter.c: In function 'parse_pred':
>> kernel/trace/trace_events_filter.c:1682:29: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
    1682 |                 pred->val = (u64)pred_val;
         |                             ^


vim +628 kernel/trace/trace_events_filter.c

   189	
   190	/*
   191	 * Without going into a formal proof, this explains the method that is used in
   192	 * parsing the logical expressions.
   193	 *
   194	 * For example, if we have: "a && !(!b || (c && g)) || d || e && !f"
   195	 * The first pass will convert it into the following program:
   196	 *
   197	 * n1: r=a;       l1: if (!r) goto l4;
   198	 * n2: r=b;       l2: if (!r) goto l4;
   199	 * n3: r=c; r=!r; l3: if (r) goto l4;
   200	 * n4: r=g; r=!r; l4: if (r) goto l5;
   201	 * n5: r=d;       l5: if (r) goto T
   202	 * n6: r=e;       l6: if (!r) goto l7;
   203	 * n7: r=f; r=!r; l7: if (!r) goto F
   204	 * T: return TRUE
   205	 * F: return FALSE
   206	 *
   207	 * To do this, we use a data structure to represent each of the above
   208	 * predicate and conditions that has:
   209	 *
   210	 *  predicate, when_to_branch, invert, target
   211	 *
   212	 * The "predicate" will hold the function to determine the result "r".
   213	 * The "when_to_branch" denotes what "r" should be if a branch is to be taken
   214	 * "&&" would contain "!r" or (0) and "||" would contain "r" or (1).
   215	 * The "invert" holds whether the value should be reversed before testing.
   216	 * The "target" contains the label "l#" to jump to.
   217	 *
   218	 * A stack is created to hold values when parentheses are used.
   219	 *
   220	 * To simplify the logic, the labels will start at 0 and not 1.
   221	 *
   222	 * The possible invert values are 1 and 0. The number of "!"s that are in scope
   223	 * before the predicate determines the invert value, if the number is odd then
   224	 * the invert value is 1 and 0 otherwise. This means the invert value only
   225	 * needs to be toggled when a new "!" is introduced compared to what is stored
   226	 * on the stack, where parentheses were used.
   227	 *
   228	 * The top of the stack and "invert" are initialized to zero.
   229	 *
   230	 * ** FIRST PASS **
   231	 *
   232	 * #1 A loop through all the tokens is done:
   233	 *
   234	 * #2 If the token is an "(", the stack is push, and the current stack value
   235	 *    gets the current invert value, and the loop continues to the next token.
   236	 *    The top of the stack saves the "invert" value to keep track of what
   237	 *    the current inversion is. As "!(a && !b || c)" would require all
   238	 *    predicates being affected separately by the "!" before the parentheses.
   239	 *    And that would end up being equivalent to "(!a || b) && !c"
   240	 *
   241	 * #3 If the token is an "!", the current "invert" value gets inverted, and
   242	 *    the loop continues. Note, if the next token is a predicate, then
   243	 *    this "invert" value is only valid for the current program entry,
   244	 *    and does not affect other predicates later on.
   245	 *
   246	 * The only other acceptable token is the predicate string.
   247	 *
   248	 * #4 A new entry into the program is added saving: the predicate and the
   249	 *    current value of "invert". The target is currently assigned to the
   250	 *    previous program index (this will not be its final value).
   251	 *
   252	 * #5 We now enter another loop and look at the next token. The only valid
   253	 *    tokens are ")", "&&", "||" or end of the input string "\0".
   254	 *
   255	 * #6 The invert variable is reset to the current value saved on the top of
   256	 *    the stack.
   257	 *
   258	 * #7 The top of the stack holds not only the current invert value, but also
   259	 *    if a "&&" or "||" needs to be processed. Note, the "&&" takes higher
   260	 *    precedence than "||". That is "a && b || c && d" is equivalent to
   261	 *    "(a && b) || (c && d)". Thus the first thing to do is to see if "&&" needs
   262	 *    to be processed. This is the case if an "&&" was the last token. If it was
   263	 *    then we call update_preds(). This takes the program, the current index in
   264	 *    the program, and the current value of "invert".  More will be described
   265	 *    below about this function.
   266	 *
   267	 * #8 If the next token is "&&" then we set a flag in the top of the stack
   268	 *    that denotes that "&&" needs to be processed, break out of this loop
   269	 *    and continue with the outer loop.
   270	 *
   271	 * #9 Otherwise, if a "||" needs to be processed then update_preds() is called.
   272	 *    This is called with the program, the current index in the program, but
   273	 *    this time with an inverted value of "invert" (that is !invert). This is
   274	 *    because the value taken will become the "when_to_branch" value of the
   275	 *    program.
   276	 *    Note, this is called when the next token is not an "&&". As stated before,
   277	 *    "&&" takes higher precedence, and "||" should not be processed yet if the
   278	 *    next logical operation is "&&".
   279	 *
   280	 * #10 If the next token is "||" then we set a flag in the top of the stack
   281	 *     that denotes that "||" needs to be processed, break out of this loop
   282	 *     and continue with the outer loop.
   283	 *
   284	 * #11 If this is the end of the input string "\0" then we break out of both
   285	 *     loops.
   286	 *
   287	 * #12 Otherwise, the next token is ")", where we pop the stack and continue
   288	 *     this inner loop.
   289	 *
   290	 * Now to discuss the update_pred() function, as that is key to the setting up
   291	 * of the program. Remember the "target" of the program is initialized to the
   292	 * previous index and not the "l" label. The target holds the index into the
   293	 * program that gets affected by the operand. Thus if we have something like
   294	 *  "a || b && c", when we process "a" the target will be "-1" (undefined).
   295	 * When we process "b", its target is "0", which is the index of "a", as that's
   296	 * the predicate that is affected by "||". But because the next token after "b"
   297	 * is "&&" we don't call update_preds(). Instead continue to "c". As the
   298	 * next token after "c" is not "&&" but the end of input, we first process the
   299	 * "&&" by calling update_preds() for the "&&" then we process the "||" by
   300	 * calling updates_preds() with the values for processing "||".
   301	 *
   302	 * What does that mean? What update_preds() does is to first save the "target"
   303	 * of the program entry indexed by the current program entry's "target"
   304	 * (remember the "target" is initialized to previous program entry), and then
   305	 * sets that "target" to the current index which represents the label "l#".
   306	 * That entry's "when_to_branch" is set to the value passed in (the "invert"
   307	 * or "!invert"). Then it sets the current program entry's target to the saved
   308	 * "target" value (the old value of the program that had its "target" updated
   309	 * to the label).
   310	 *
   311	 * Looking back at "a || b && c", we have the following steps:
   312	 *  "a"  - prog[0] = { "a", X, -1 } // pred, when_to_branch, target
   313	 *  "||" - flag that we need to process "||"; continue outer loop
   314	 *  "b"  - prog[1] = { "b", X, 0 }
   315	 *  "&&" - flag that we need to process "&&"; continue outer loop
   316	 * (Notice we did not process "||")
   317	 *  "c"  - prog[2] = { "c", X, 1 }
   318	 *  update_preds(prog, 2, 0); // invert = 0 as we are processing "&&"
   319	 *    t = prog[2].target; // t = 1
   320	 *    s = prog[t].target; // s = 0
   321	 *    prog[t].target = 2; // Set target to "l2"
   322	 *    prog[t].when_to_branch = 0;
   323	 *    prog[2].target = s;
   324	 * update_preds(prog, 2, 1); // invert = 1 as we are now processing "||"
   325	 *    t = prog[2].target; // t = 0
   326	 *    s = prog[t].target; // s = -1
   327	 *    prog[t].target = 2; // Set target to "l2"
   328	 *    prog[t].when_to_branch = 1;
   329	 *    prog[2].target = s;
   330	 *
   331	 * #13 Which brings us to the final step of the first pass, which is to set
   332	 *     the last program entry's when_to_branch and target, which will be
   333	 *     when_to_branch = 0; target = N; ( the label after the program entry after
   334	 *     the last program entry processed above).
   335	 *
   336	 * If we denote "TRUE" to be the entry after the last program entry processed,
   337	 * and "FALSE" the program entry after that, we are now done with the first
   338	 * pass.
   339	 *
   340	 * Making the above "a || b && c" have a program of:
   341	 *  prog[0] = { "a", 1, 2 }
   342	 *  prog[1] = { "b", 0, 2 }
   343	 *  prog[2] = { "c", 0, 3 }
   344	 *
   345	 * Which translates into:
   346	 * n0: r = a; l0: if (r) goto l2;
   347	 * n1: r = b; l1: if (!r) goto l2;
   348	 * n2: r = c; l2: if (!r) goto l3;  // Which is the same as "goto F;"
   349	 * T: return TRUE; l3:
   350	 * F: return FALSE
   351	 *
   352	 * Although, after the first pass, the program is correct, it is
   353	 * inefficient. The simple sample of "a || b && c" could be easily been
   354	 * converted into:
   355	 * n0: r = a; if (r) goto T
   356	 * n1: r = b; if (!r) goto F
   357	 * n2: r = c; if (!r) goto F
   358	 * T: return TRUE;
   359	 * F: return FALSE;
   360	 *
   361	 * The First Pass is over the input string. The next too passes are over
   362	 * the program itself.
   363	 *
   364	 * ** SECOND PASS **
   365	 *
   366	 * Which brings us to the second pass. If a jump to a label has the
   367	 * same condition as that label, it can instead jump to its target.
   368	 * The original example of "a && !(!b || (c && g)) || d || e && !f"
   369	 * where the first pass gives us:
   370	 *
   371	 * n1: r=a;       l1: if (!r) goto l4;
   372	 * n2: r=b;       l2: if (!r) goto l4;
   373	 * n3: r=c; r=!r; l3: if (r) goto l4;
   374	 * n4: r=g; r=!r; l4: if (r) goto l5;
   375	 * n5: r=d;       l5: if (r) goto T
   376	 * n6: r=e;       l6: if (!r) goto l7;
   377	 * n7: r=f; r=!r; l7: if (!r) goto F:
   378	 * T: return TRUE;
   379	 * F: return FALSE
   380	 *
   381	 * We can see that "l3: if (r) goto l4;" and at l4, we have "if (r) goto l5;".
   382	 * And "l5: if (r) goto T", we could optimize this by converting l3 and l4
   383	 * to go directly to T. To accomplish this, we start from the last
   384	 * entry in the program and work our way back. If the target of the entry
   385	 * has the same "when_to_branch" then we could use that entry's target.
   386	 * Doing this, the above would end up as:
   387	 *
   388	 * n1: r=a;       l1: if (!r) goto l4;
   389	 * n2: r=b;       l2: if (!r) goto l4;
   390	 * n3: r=c; r=!r; l3: if (r) goto T;
   391	 * n4: r=g; r=!r; l4: if (r) goto T;
   392	 * n5: r=d;       l5: if (r) goto T;
   393	 * n6: r=e;       l6: if (!r) goto F;
   394	 * n7: r=f; r=!r; l7: if (!r) goto F;
   395	 * T: return TRUE
   396	 * F: return FALSE
   397	 *
   398	 * In that same pass, if the "when_to_branch" doesn't match, we can simply
   399	 * go to the program entry after the label. That is, "l2: if (!r) goto l4;"
   400	 * where "l4: if (r) goto T;", then we can convert l2 to be:
   401	 * "l2: if (!r) goto n5;".
   402	 *
   403	 * This will have the second pass give us:
   404	 * n1: r=a;       l1: if (!r) goto n5;
   405	 * n2: r=b;       l2: if (!r) goto n5;
   406	 * n3: r=c; r=!r; l3: if (r) goto T;
   407	 * n4: r=g; r=!r; l4: if (r) goto T;
   408	 * n5: r=d;       l5: if (r) goto T
   409	 * n6: r=e;       l6: if (!r) goto F;
   410	 * n7: r=f; r=!r; l7: if (!r) goto F
   411	 * T: return TRUE
   412	 * F: return FALSE
   413	 *
   414	 * Notice, all the "l#" labels are no longer used, and they can now
   415	 * be discarded.
   416	 *
   417	 * ** THIRD PASS **
   418	 *
   419	 * For the third pass we deal with the inverts. As they simply just
   420	 * make the "when_to_branch" get inverted, a simple loop over the
   421	 * program to that does: "when_to_branch ^= invert;" will do the
   422	 * job, leaving us with:
   423	 * n1: r=a; if (!r) goto n5;
   424	 * n2: r=b; if (!r) goto n5;
   425	 * n3: r=c: if (!r) goto T;
   426	 * n4: r=g; if (!r) goto T;
   427	 * n5: r=d; if (r) goto T
   428	 * n6: r=e; if (!r) goto F;
   429	 * n7: r=f; if (r) goto F
   430	 * T: return TRUE
   431	 * F: return FALSE
   432	 *
   433	 * As "r = a; if (!r) goto n5;" is obviously the same as
   434	 * "if (!a) goto n5;" without doing anything we can interpret the
   435	 * program as:
   436	 * n1: if (!a) goto n5;
   437	 * n2: if (!b) goto n5;
   438	 * n3: if (!c) goto T;
   439	 * n4: if (!g) goto T;
   440	 * n5: if (d) goto T
   441	 * n6: if (!e) goto F;
   442	 * n7: if (f) goto F
   443	 * T: return TRUE
   444	 * F: return FALSE
   445	 *
   446	 * Since the inverts are discarded at the end, there's no reason to store
   447	 * them in the program array (and waste memory). A separate array to hold
   448	 * the inverts is used and freed at the end.
   449	 */
   450	static struct prog_entry *
   451	predicate_parse(const char *str, int nr_parens, int nr_preds,
   452			parse_pred_fn parse_pred, void *data,
   453			struct filter_parse_error *pe)
   454	{
   455		struct prog_entry *prog_stack;
   456		struct prog_entry *prog;
   457		const char *ptr = str;
   458		char *inverts = NULL;
   459		int *op_stack;
   460		int *top;
   461		int invert = 0;
   462		int ret = -ENOMEM;
   463		int len;
   464		int N = 0;
   465		int i;
   466	
   467		nr_preds += 2; /* For TRUE and FALSE */
   468	
   469		op_stack = kmalloc_array(nr_parens, sizeof(*op_stack), GFP_KERNEL);
   470		if (!op_stack)
   471			return ERR_PTR(-ENOMEM);
   472		prog_stack = kcalloc(nr_preds, sizeof(*prog_stack), GFP_KERNEL);
   473		if (!prog_stack) {
   474			parse_error(pe, -ENOMEM, 0);
   475			goto out_free;
   476		}
   477		inverts = kmalloc_array(nr_preds, sizeof(*inverts), GFP_KERNEL);
   478		if (!inverts) {
   479			parse_error(pe, -ENOMEM, 0);
   480			goto out_free;
   481		}
   482	
   483		top = op_stack;
   484		prog = prog_stack;
   485		*top = 0;
   486	
   487		/* First pass */
   488		while (*ptr) {						/* #1 */
   489			const char *next = ptr++;
   490	
   491			if (isspace(*next))
   492				continue;
   493	
   494			switch (*next) {
   495			case '(':					/* #2 */
   496				if (top - op_stack > nr_parens) {
   497					ret = -EINVAL;
   498					goto out_free;
   499				}
   500				*(++top) = invert;
   501				continue;
   502			case '!':					/* #3 */
   503				if (!is_not(next))
   504					break;
   505				invert = !invert;
   506				continue;
   507			}
   508	
   509			if (N >= nr_preds) {
   510				parse_error(pe, FILT_ERR_TOO_MANY_PREDS, next - str);
   511				goto out_free;
   512			}
   513	
   514			inverts[N] = invert;				/* #4 */
   515			prog[N].target = N-1;
   516	
   517			len = parse_pred(next, data, ptr - str, pe, &prog[N].pred);
   518			if (len < 0) {
   519				ret = len;
   520				goto out_free;
   521			}
   522			ptr = next + len;
   523	
   524			N++;
   525	
   526			ret = -1;
   527			while (1) {					/* #5 */
   528				next = ptr++;
   529				if (isspace(*next))
   530					continue;
   531	
   532				switch (*next) {
   533				case ')':
   534				case '\0':
   535					break;
   536				case '&':
   537				case '|':
   538					/* accepting only "&&" or "||" */
   539					if (next[1] == next[0]) {
   540						ptr++;
   541						break;
   542					}
   543					fallthrough;
   544				default:
   545					parse_error(pe, FILT_ERR_TOO_MANY_PREDS,
   546						    next - str);
   547					goto out_free;
   548				}
   549	
   550				invert = *top & INVERT;
   551	
   552				if (*top & PROCESS_AND) {		/* #7 */
   553					update_preds(prog, N - 1, invert);
   554					*top &= ~PROCESS_AND;
   555				}
   556				if (*next == '&') {			/* #8 */
   557					*top |= PROCESS_AND;
   558					break;
   559				}
   560				if (*top & PROCESS_OR) {		/* #9 */
   561					update_preds(prog, N - 1, !invert);
   562					*top &= ~PROCESS_OR;
   563				}
   564				if (*next == '|') {			/* #10 */
   565					*top |= PROCESS_OR;
   566					break;
   567				}
   568				if (!*next)				/* #11 */
   569					goto out;
   570	
   571				if (top == op_stack) {
   572					ret = -1;
   573					/* Too few '(' */
   574					parse_error(pe, FILT_ERR_TOO_MANY_CLOSE, ptr - str);
   575					goto out_free;
   576				}
   577				top--;					/* #12 */
   578			}
   579		}
   580	 out:
   581		if (top != op_stack) {
   582			/* Too many '(' */
   583			parse_error(pe, FILT_ERR_TOO_MANY_OPEN, ptr - str);
   584			goto out_free;
   585		}
   586	
   587		if (!N) {
   588			/* No program? */
   589			ret = -EINVAL;
   590			parse_error(pe, FILT_ERR_NO_FILTER, ptr - str);
   591			goto out_free;
   592		}
   593	
   594		prog[N].pred = NULL;					/* #13 */
   595		prog[N].target = 1;		/* TRUE */
   596		prog[N+1].pred = NULL;
   597		prog[N+1].target = 0;		/* FALSE */
   598		prog[N-1].target = N;
   599		prog[N-1].when_to_branch = false;
   600	
   601		/* Second Pass */
   602		for (i = N-1 ; i--; ) {
   603			int target = prog[i].target;
   604			if (prog[i].when_to_branch == prog[target].when_to_branch)
   605				prog[i].target = prog[target].target;
   606		}
   607	
   608		/* Third Pass */
   609		for (i = 0; i < N; i++) {
   610			invert = inverts[i] ^ prog[i].when_to_branch;
   611			prog[i].when_to_branch = invert;
   612			/* Make sure the program always moves forward */
   613			if (WARN_ON(prog[i].target <= i)) {
   614				ret = -EINVAL;
   615				goto out_free;
   616			}
   617		}
   618	
   619		kfree(op_stack);
   620		kfree(inverts);
   621		return prog;
   622	out_free:
   623		kfree(op_stack);
   624		kfree(inverts);
   625		if (prog_stack) {
   626			for (i = 0; prog_stack[i].pred; i++) {
   627				if (prog_stack[i].pred->fn_num == FILTER_PRED_FN_MEMCMP)
 > 628					kfree((u8 *)prog_stack[i].pred->val);
   629				kfree(prog_stack[i].pred);
   630			}
   631			kfree(prog_stack);
   632		}
   633		return ERR_PTR(ret);
   634	}
   635	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
